#!/usr/bin/env python3
import sys
import os
import subprocess
import time
import threading
from PyQt6.QtCore import Qt, QSize, QPoint, QEvent, pyqtSignal
from PyQt6.QtGui import QColor, QPainter, QFont, QIcon, QPixmap, QImage, QCursor
from PyQt6.QtWidgets import (
    QApplication, QWidget, QVBoxLayout, QHBoxLayout, QLabel,
    QScrollArea, QFrame, QPushButton, QStackedWidget, QGridLayout,
    QMenu
)

# Simulate Ctrl+V on Wayland via kernel uinput device (ydotool)
def paste_now():
    time.sleep(0.11)
    try:
        subprocess.run(
            ['ydotool', 'key', '29:1', '47:1', '47:0', '29:0'],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL
        )
    except Exception:
        pass

class ClipboardCard(QFrame):
    def __init__(self, index, text=None, pixmap=None, raw_image_bytes=None, is_pinned=False, on_paste=None, on_delete=None, on_toggle_pin=None):
        super().__init__()
        self.index = index
        self.text_content = text
        self.pixmap_content = pixmap
        self.raw_image_bytes = raw_image_bytes
        self.is_pinned = is_pinned
        self.on_paste = on_paste
        self.on_delete = on_delete
        self.on_toggle_pin = on_toggle_pin

        self.setCursor(Qt.CursorShape.PointingHandCursor)
        self.setObjectName("card")
        self._update_style(hover=False)

        # Main horizontal layout
        main_layout = QHBoxLayout(self)
        main_layout.setContentsMargins(14, 12, 10, 12)
        main_layout.setSpacing(10)

        # Left content container
        content_box = QVBoxLayout()
        content_box.setContentsMargins(0, 0, 0, 0)
        content_box.setSpacing(4)

        if self.pixmap_content:
            img_label = QLabel()
            scaled_pixmap = self.pixmap_content.scaled(
                280, 150,
                Qt.AspectRatioMode.KeepAspectRatio,
                Qt.TransformationMode.SmoothTransformation
            )
            img_label.setPixmap(scaled_pixmap)
            img_label.setAlignment(Qt.AlignmentFlag.AlignLeft | Qt.AlignmentFlag.AlignVCenter)
            img_label.setStyleSheet("border-radius: 6px; background: transparent; border: none;")
            content_box.addWidget(img_label)
        elif self.text_content:
            txt_label = QLabel(self.text_content[:280])
            txt_label.setWordWrap(True)
            txt_label.setStyleSheet("color: #ffffff; font-size: 13px; line-height: 1.4; border: none; background: transparent;")
            content_box.addWidget(txt_label)

        main_layout.addLayout(content_box, stretch=1)

        # Right actions container (3 dots top, pin bottom)
        actions_box = QVBoxLayout()
        actions_box.setContentsMargins(0, 0, 0, 0)
        actions_box.setSpacing(0)

        # 3 dots menu button
        self.dots_btn = QPushButton("•••")
        self.dots_btn.setFixedSize(26, 22)
        self.dots_btn.setCursor(Qt.CursorShape.PointingHandCursor)
        self.dots_btn.setStyleSheet("""
            QPushButton {
                background: transparent;
                color: #888888;
                border: none;
                font-size: 13px;
                border-radius: 4px;
            }
            QPushButton:hover {
                background: rgba(255, 255, 255, 0.12);
                color: #ffffff;
            }
        """)
        self.dots_btn.clicked.connect(self._show_context_menu)
        actions_box.addWidget(self.dots_btn, alignment=Qt.AlignmentFlag.AlignTop | Qt.AlignmentFlag.AlignRight)

        actions_box.addStretch(1)

        # Pin button
        self.pin_btn = QPushButton("📌" if self.is_pinned else "📍")
        self.pin_btn.setFixedSize(26, 26)
        self.pin_btn.setCursor(Qt.CursorShape.PointingHandCursor)
        self.pin_btn.setToolTip("Unpin" if self.is_pinned else "Pin")
        pin_color = "#60cdff" if self.is_pinned else "#777777"
        self.pin_btn.setStyleSheet(f"""
            QPushButton {{
                background: transparent;
                color: {pin_color};
                border: none;
                font-size: 13px;
                border-radius: 4px;
            }}
            QPushButton:hover {{
                background: rgba(255, 255, 255, 0.12);
                color: #ffffff;
            }}
        """)
        self.pin_btn.clicked.connect(self._handle_pin)
        actions_box.addWidget(self.pin_btn, alignment=Qt.AlignmentFlag.AlignBottom | Qt.AlignmentFlag.AlignRight)

        main_layout.addLayout(actions_box)

    def _update_style(self, hover=False):
        if hover:
            self.setStyleSheet("""
                QFrame#card {
                    background-color: #353535;
                    border: 1px solid rgba(255, 255, 255, 0.16);
                    border-radius: 8px;
                }
            """)
        else:
            border_color = "rgba(96, 205, 255, 0.5)" if self.is_pinned else "rgba(255, 255, 255, 0.08)"
            self.setStyleSheet(f"""
                QFrame#card {{
                    background-color: #2b2b2b;
                    border: 1px solid {border_color};
                    border-radius: 8px;
                }}
            """)

    def enterEvent(self, event):
        self._update_style(hover=True)
        super().enterEvent(event)

    def leaveEvent(self, event):
        self._update_style(hover=False)
        super().leaveEvent(event)

    def mousePressEvent(self, event):
        if event.button() == Qt.MouseButton.LeftButton:
            # Check if clicked on buttons
            if not self.dots_btn.underMouse() and not self.pin_btn.underMouse():
                if self.on_paste:
                    self.on_paste(self.index, self.text_content, self.raw_image_bytes)
        super().mousePressEvent(event)

    def _handle_pin(self):
        if self.on_toggle_pin:
            self.on_toggle_pin(self.index, not self.is_pinned)

    def _show_context_menu(self):
        menu = QMenu(self)
        menu.setStyleSheet("""
            QMenu {
                background-color: #252525;
                color: #ffffff;
                border: 1px solid rgba(255, 255, 255, 0.12);
                border-radius: 8px;
                padding: 4px;
            }
            QMenu::item {
                padding: 6px 20px;
                border-radius: 4px;
                font-size: 12px;
            }
            QMenu::item:selected {
                background-color: rgba(255, 255, 255, 0.12);
            }
        """)
        pin_act = menu.addAction("Unpin" if self.is_pinned else "Pin")
        del_act = menu.addAction("Delete")
        
        action = menu.exec(QCursor.pos())
        if action == pin_act:
            self._handle_pin()
        elif action == del_act:
            if self.on_delete:
                self.on_delete(self.index)

class Win11ClipboardWindow(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowFlags(
            Qt.WindowType.Dialog |
            Qt.WindowType.FramelessWindowHint |
            Qt.WindowType.WindowStaysOnTopHint
        )
        self.setAttribute(Qt.WidgetAttribute.WA_TranslucentBackground)
        self.shown_time = time.time()
        self.resize(390, 560)
        self._init_ui()
        self._center_or_position()

    def _center_or_position(self):
        screen = QApplication.primaryScreen().geometry()
        x = (screen.width() - self.width()) // 2
        y = screen.height() - self.height() - 65
        self.move(x, y)

    def _init_ui(self):
        root_layout = QVBoxLayout(self)
        root_layout.setContentsMargins(10, 10, 10, 10)

        # Background container
        self.container = QFrame(self)
        self.container.setObjectName("container")
        self.container.setStyleSheet("""
            QFrame#container {
                background-color: #202020;
                border: 1px solid rgba(255, 255, 255, 0.12);
                border-radius: 12px;
            }
        """)
        root_layout.addWidget(self.container)

        c_layout = QVBoxLayout(self.container)
        c_layout.setContentsMargins(14, 8, 14, 14)
        c_layout.setSpacing(10)

        # Top Grab Bar and Close Button
        top_bar = QHBoxLayout()
        top_bar.setContentsMargins(0, 0, 0, 0)
        top_bar.addSpacing(28) # balance close button

        top_bar.addStretch()
        grab_handle = QFrame()
        grab_handle.setFixedSize(32, 4)
        grab_handle.setStyleSheet("background-color: #555555; border-radius: 2px;")
        top_bar.addWidget(grab_handle)
        top_bar.addStretch()

        close_btn = QPushButton("✕")
        close_btn.setFixedSize(26, 24)
        close_btn.setCursor(Qt.CursorShape.PointingHandCursor)
        close_btn.setStyleSheet("""
            QPushButton {
                background: transparent;
                color: #888888;
                border: none;
                font-size: 12px;
                border-radius: 4px;
            }
            QPushButton:hover {
                background: #c42b1c;
                color: #ffffff;
            }
        """)
        close_btn.clicked.connect(self.close)
        top_bar.addWidget(close_btn)
        c_layout.addLayout(top_bar)

        # Horizontal Category Tabs (Exact match with Windows 11 screenshot)
        nav_layout = QHBoxLayout()
        nav_layout.setContentsMargins(4, 0, 4, 0)
        nav_layout.setSpacing(6)

        self.tab_buttons = []
        self.tab_indicators = []
        
        # Tabs info: (Icon, label, is_default_active)
        tabs_info = [
            ("🤍", "Recent", False),
            ("🙂", "Emoji", False),
            ("GIF", "GIFs", False),
            ("; -)", "Kaomoji", False),
            ("% ↺\nΔ +", "Symbols", False),
            ("📋", "Clipboard", True) # Default active tab index 5
        ]

        self.active_tab_index = 5

        for idx, (icon_text, tooltip, is_active) in enumerate(tabs_info):
            tab_widget = QWidget()
            tab_widget.setFixedWidth(46)
            tab_l = QVBoxLayout(tab_widget)
            tab_l.setContentsMargins(0, 0, 0, 0)
            tab_l.setSpacing(3)

            btn = QPushButton(icon_text)
            btn.setFixedSize(46, 32)
            btn.setToolTip(tooltip)
            btn.setCursor(Qt.CursorShape.PointingHandCursor)
            
            font_sz = "10px" if "\n" in icon_text or len(icon_text) > 3 else "14px"
            btn.setStyleSheet(f"""
                QPushButton {{
                    background: transparent;
                    color: {'#ffffff' if is_active else '#999999'};
                    border: none;
                    border-radius: 4px;
                    font-size: {font_sz};
                    font-weight: 500;
                }}
                QPushButton:hover {{
                    background: rgba(255, 255, 255, 0.08);
                    color: #ffffff;
                }}
            """)
            btn.clicked.connect(lambda checked, i=idx: self.switch_tab(i))
            tab_l.addWidget(btn)

            indicator = QFrame()
            indicator.setFixedHeight(3)
            indicator.setStyleSheet(f"background-color: {'#60cdff' if is_active else 'transparent'}; border-radius: 1.5px;")
            tab_l.addWidget(indicator)

            nav_layout.addWidget(tab_widget)
            self.tab_buttons.append(btn)
            self.tab_indicators.append(indicator)

        c_layout.addLayout(nav_layout)

        # Header Row: "Clipboard" title + "Clear all" button
        header_layout = QHBoxLayout()
        header_layout.setContentsMargins(4, 4, 4, 0)
        self.title_lbl = QLabel("Clipboard")
        self.title_lbl.setStyleSheet("color: #ffffff; font-size: 16px; font-weight: 600; border: none; background: transparent;")
        header_layout.addWidget(self.title_lbl)
        header_layout.addStretch()

        self.clear_btn = QPushButton("Clear all")
        self.clear_btn.setCursor(Qt.CursorShape.PointingHandCursor)
        self.clear_btn.setStyleSheet("""
            QPushButton {
                background: #2b2b2b;
                color: #ffffff;
                border: 1px solid rgba(255, 255, 255, 0.1);
                font-size: 12px;
                font-weight: 500;
                padding: 5px 14px;
                border-radius: 5px;
            }
            QPushButton:hover {
                background: #353535;
                border: 1px solid rgba(255, 255, 255, 0.2);
            }
        """)
        self.clear_btn.clicked.connect(self.clear_all)
        header_layout.addWidget(self.clear_btn)
        c_layout.addLayout(header_layout)

        # Stacked Pages
        self.stack = QStackedWidget()
        c_layout.addWidget(self.stack)

        # Page 0: Recent
        self.stack.addWidget(self._build_placeholder_page("No recent items."))

        # Page 1: Emojis
        self.stack.addWidget(self._build_grid_page([
            "😀","😃","😄","😁","😆","😅","😂","🤣","😊","😇",
            "🙂","🙃","😉","😌","😍","🥰","😘","😗","😙","😚",
            "😋","😛","😝","😜","🤪","🤨","🧐","🤓","😎","🤩",
            "🥳","😏","😒","😞","😔","😟","😕","🙁","☹️","😣",
            "😖","😫","😩","🥺","😢","😭","😤","😠","😡","🤬",
            "🤯","😳","🥵","🥶","😱","😨","😰","😥","😓","🤗",
            "🤔","🤭","🤫","🤥","😶","😐","😑","😬","🙄","😯",
            "👍","👎","👏","🙌","🤝","🙏","✌️","🤞","💪","❤️",
            "🔥","✨","🎉","🚀","💯","🌟","⭐","💡","⚡","🍕"
        ]))

        # Page 2: GIFs
        self.stack.addWidget(self._build_placeholder_page("GIF search is coming soon."))

        # Page 3: Kaomoji
        self.stack.addWidget(self._build_list_page([
            "(^_^)", "(•‿•)", "(◕‿◕)", "(づ｡◕‿‿◕｡)づ",
            "(╯°□°)╯︵ ┻━┻", "┬─┬ノ( º _ ºノ)", "¯\\_(ツ)_/¯",
            "( ͡° ͜ʖ ͡°)", "(¬‿¬)", "ಠ_ಠ", "(ง'̀-'́)ง",
            "(*^▽^*)", "(≧◡≦)", "(❤ω❤)", "(T_T)",
            "(;´༎ຶД༎ຶ`)", "(⊙_⊙)", "＼(＾O＾)／", "ヘ( ^o^)ノ"
        ]))

        # Page 4: Symbols
        self.stack.addWidget(self._build_grid_page([
            "$", "€", "£", "¥", "₺", "₽", "₩", "¢",
            "±", "×", "÷", "≠", "≈", "≤", "≥", "√", "∞", "π", "∑", "∆",
            "©", "®", "™", "°", "•", "★", "✓", "✗",
            "←", "→", "↑", "↓", "↔", "↕", "⇒", "⇔"
        ], font_size=16))

        # Page 5: Clipboard (Default active)
        self.clip_page = QWidget()
        clip_layout = QVBoxLayout(self.clip_page)
        clip_layout.setContentsMargins(0, 0, 0, 0)

        self.scroll = QScrollArea()
        self.scroll.setWidgetResizable(True)
        self.scroll.setStyleSheet("""
            QScrollArea {
                border: none;
                background: transparent;
            }
            QScrollBar:vertical {
                background: transparent;
                width: 6px;
                margin: 0px;
            }
            QScrollBar::handle:vertical {
                background: rgba(255, 255, 255, 0.2);
                border-radius: 3px;
                min-height: 24px;
            }
            QScrollBar::handle:vertical:hover {
                background: rgba(255, 255, 255, 0.35);
            }
            QScrollBar::add-line:vertical, QScrollBar::sub-line:vertical {
                height: 0px;
            }
        """)

        self.cards_container = QWidget()
        self.cards_container.setStyleSheet("background: transparent;")
        self.cards_layout = QVBoxLayout(self.cards_container)
        self.cards_layout.setContentsMargins(0, 4, 4, 0)
        self.cards_layout.setSpacing(8)
        self.cards_layout.addStretch()

        self.scroll.setWidget(self.cards_container)
        clip_layout.addWidget(self.scroll)
        self.stack.addWidget(self.clip_page)

        # Switch to clipboard page by default
        self.switch_tab(5)
        self.load_history()

    def _build_placeholder_page(self, text):
        page = QWidget()
        layout = QVBoxLayout(page)
        lbl = QLabel(text)
        lbl.setAlignment(Qt.AlignmentFlag.AlignCenter)
        lbl.setStyleSheet("color: #888888; font-size: 13px;")
        layout.addWidget(lbl)
        return page

    def _build_grid_page(self, items, font_size=18):
        page = QWidget()
        layout = QVBoxLayout(page)
        layout.setContentsMargins(0, 0, 0, 0)
        scroll = QScrollArea()
        scroll.setWidgetResizable(True)
        scroll.setStyleSheet("border: none; background: transparent;")
        cont = QWidget()
        cont.setStyleSheet("background: transparent;")
        grid = QGridLayout(cont)
        grid.setContentsMargins(0, 4, 4, 0)
        grid.setSpacing(6)

        cols = 6
        for i, text in enumerate(items):
            btn = QPushButton(text)
            btn.setFixedSize(50, 46)
            btn.setCursor(Qt.CursorShape.PointingHandCursor)
            btn.setStyleSheet(f"""
                QPushButton {{
                    background: #2b2b2b;
                    color: #ffffff;
                    border: 1px solid rgba(255, 255, 255, 0.08);
                    border-radius: 6px;
                    font-size: {font_size}px;
                }}
                QPushButton:hover {{
                    background: #383838;
                    border: 1px solid #60cdff;
                }}
            """)
            btn.clicked.connect(lambda checked, t=text: self.paste_text(t))
            grid.addWidget(btn, i // cols, i % cols)

        scroll.setWidget(cont)
        layout.addWidget(scroll)
        return page

    def _build_list_page(self, items):
        page = QWidget()
        layout = QVBoxLayout(page)
        layout.setContentsMargins(0, 0, 0, 0)
        scroll = QScrollArea()
        scroll.setWidgetResizable(True)
        scroll.setStyleSheet("border: none; background: transparent;")
        cont = QWidget()
        cont.setStyleSheet("background: transparent;")
        l = QVBoxLayout(cont)
        l.setContentsMargins(0, 4, 4, 0)
        l.setSpacing(6)

        for text in items:
            btn = QPushButton(text)
            btn.setFixedHeight(40)
            btn.setCursor(Qt.CursorShape.PointingHandCursor)
            btn.setStyleSheet("""
                QPushButton {
                    background: #2b2b2b;
                    color: #ffffff;
                    border: 1px solid rgba(255, 255, 255, 0.08);
                    border-radius: 6px;
                    font-size: 13px;
                    padding-left: 14px;
                    text-align: left;
                }
                QPushButton:hover {{
                    background: #383838;
                    border: 1px solid #60cdff;
                }}
            """)
            btn.clicked.connect(lambda checked, t=text: self.paste_text(t))
            l.addWidget(btn)

        l.addStretch()
        scroll.setWidget(cont)
        layout.addWidget(scroll)
        return page

    def switch_tab(self, idx):
        self.active_tab_index = idx
        self.stack.setCurrentIndex(idx)

        titles = ["Recent", "Emoji", "GIFs", "Kaomoji", "Symbols", "Clipboard"]
        self.title_lbl.setText(titles[idx])
        self.clear_btn.setVisible(idx == 5)

        for i in range(len(self.tab_buttons)):
            is_cur = (i == idx)
            self.tab_indicators[i].setStyleSheet(
                f"background-color: {'#60cdff' if is_cur else 'transparent'}; border-radius: 1.5px;"
            )
            font_sz = "10px" if "\n" in self.tab_buttons[i].text() or len(self.tab_buttons[i].text()) > 3 else "14px"
            self.tab_buttons[i].setStyleSheet(f"""
                QPushButton {{
                    background: transparent;
                    color: {'#ffffff' if is_cur else '#888888'};
                    border: none;
                    border-radius: 4px;
                    font-size: {font_sz};
                    font-weight: {'600' if is_cur else '500'};
                }}
                QPushButton:hover {{
                    background: rgba(255, 255, 255, 0.08);
                    color: #ffffff;
                }}
            """)

    def load_history(self):
        import json
        while self.cards_layout.count() > 1:
            child = self.cards_layout.takeAt(0)
            if child.widget():
                child.widget().deleteLater()

        script = """
        var res = [];
        var n = Math.min(count(), 40);
        for (var i = 0; i < n; i++) {
            var isPin = plugins.itempinned.isPinned(i);
            var m = str(read('?', i));
            var isImg = m.indexOf('image/png') !== -1;
            var txt = isImg ? '' : str(read('text/plain', i));
            res.push({ i: i, pinned: isPin, isImg: isImg, text: txt });
        }
        print(JSON.stringify(res));
        """
        try:
            out = subprocess.check_output(['copyq', 'eval', script]).decode('utf-8', errors='ignore')
            items = json.loads(out)
        except Exception:
            items = []

        if not items:
            empty_lbl = QLabel("Nothing here\\nYou'll see your clipboard history here once you've copied something.")
            empty_lbl.setAlignment(Qt.AlignmentFlag.AlignCenter)
            empty_lbl.setStyleSheet("color: #888888; font-size: 13px; padding-top: 80px;")
            self.cards_layout.insertWidget(0, empty_lbl)
            return

        for item in items:
            idx = item['i']
            is_pinned = item.get('pinned', False)
            if item.get('isImg'):
                try:
                    raw_img = subprocess.check_output(['copyq', 'read', 'image/png', str(idx)])
                    img = QImage.fromData(raw_img)
                    pixmap = QPixmap.fromImage(img)
                    card = ClipboardCard(
                        idx,
                        pixmap=pixmap,
                        raw_image_bytes=raw_img,
                        is_pinned=is_pinned,
                        on_paste=self.on_card_paste,
                        on_delete=self.on_card_delete,
                        on_toggle_pin=self.on_toggle_pin
                    )
                    self.cards_layout.insertWidget(self.cards_layout.count() - 1, card)
                except Exception:
                    pass
            elif item.get('text'):
                card = ClipboardCard(
                    idx,
                    text=item['text'],
                    is_pinned=is_pinned,
                    on_paste=self.on_card_paste,
                    on_delete=self.on_card_delete,
                    on_toggle_pin=self.on_toggle_pin
                )
                self.cards_layout.insertWidget(self.cards_layout.count() - 1, card)

    def on_card_paste(self, index, text, raw_image_bytes):
        try:
            subprocess.run(['copyq', 'select', str(index)], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            if raw_image_bytes:
                # Also feed into wl-copy for instant Wayland compatibility
                p = subprocess.Popen(['wl-copy', '--type', 'image/png'], stdin=subprocess.PIPE)
                p.communicate(input=raw_image_bytes)
            elif text:
                p = subprocess.Popen(['wl-copy', '--type', 'text/plain;charset=utf-8'], stdin=subprocess.PIPE)
                p.communicate(input=text.encode('utf-8'))
        except Exception:
            pass

        self.hide()
        self.close()
        threading.Thread(target=paste_now, daemon=True).start()

    def paste_text(self, text):
        try:
            p = subprocess.Popen(['wl-copy', '--type', 'text/plain;charset=utf-8'], stdin=subprocess.PIPE)
            p.communicate(input=text.encode('utf-8'))
        except Exception:
            pass

        self.hide()
        self.close()
        threading.Thread(target=paste_now, daemon=True).start()

    def on_toggle_pin(self, index, should_pin):
        action = "pin" if should_pin else "unpin"
        try:
            subprocess.run(['copyq', 'eval', f'plugins.itempinned.{action}({index})'], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            self.load_history()
        except Exception:
            pass

    def on_card_delete(self, index):
        try:
            subprocess.run(['copyq', 'remove', str(index)], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            self.load_history()
        except Exception:
            pass

    def clear_all(self):
        try:
            # CopyQ clear keeps pinned items
            subprocess.run(['copyq', 'clear'], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            self.load_history()
        except Exception:
            pass

    def keyPressEvent(self, event):
        if event.key() == Qt.Key.Key_Escape:
            self.close()
        super().keyPressEvent(event)

    def changeEvent(self, event):
        if event.type() == QEvent.Type.ActivationChange:
            if time.time() - getattr(self, 'shown_time', 0) > 1.2:
                if not self.isActiveWindow():
                    self.close()
        super().changeEvent(event)

import atexit
import signal

def cleanup_pid():
    lock_file = '/tmp/win11_clipboard.pid'
    if os.path.exists(lock_file):
        try:
            os.remove(lock_file)
        except Exception:
            pass

def main():
    lock_file = '/tmp/win11_clipboard.pid'
    if os.path.exists(lock_file):
        try:
            with open(lock_file, 'r') as f:
                pid = int(f.read().strip())
            # Check if process is really alive
            os.kill(pid, 0)
            # If alive, kill it (toggle behavior)
            os.kill(pid, 15)
            cleanup_pid()
            return
        except ProcessLookupError:
            cleanup_pid()
        except Exception:
            cleanup_pid()

    atexit.register(cleanup_pid)
    signal.signal(signal.SIGTERM, lambda s, f: sys.exit(0))
    signal.signal(signal.SIGINT, lambda s, f: sys.exit(0))

    try:
        with open(lock_file, 'w') as f:
            f.write(str(os.getpid()))
    except Exception:
        pass

    app = QApplication(sys.argv)
    app.setStyle("Fusion")
    win = Win11ClipboardWindow()
    win.show()
    win.raise_()
    win.activateWindow()

    ret = app.exec()
    if os.path.exists(lock_file):
        os.remove(lock_file)
    sys.exit(ret)

if __name__ == '__main__':
    main()
