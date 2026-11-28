#!/usr/bin/env python3
import sys
import os
import subprocess
import time
import threading
from PyQt6.QtCore import Qt, QSize, QPoint, QEvent, QByteArray
from PyQt6.QtGui import QColor, QPainter, QPainterPath, QPen, QFont, QIcon, QPixmap, QImage, QCursor
from PyQt6.QtWidgets import (
    QApplication, QWidget, QVBoxLayout, QHBoxLayout, QLabel,
    QScrollArea, QFrame, QPushButton, QLineEdit, QStackedWidget,
    QGridLayout, QSizePolicy
)

# Linux keycodes for ydotool:
# 29: KEY_LEFTCTRL, 47: KEY_V
def paste_now():
    time.sleep(0.09)
    try:
        subprocess.run(['ydotool', 'key', '29:1', '47:1', '47:0', '29:0'], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    except Exception as e:
        pass

class ClipboardCard(QFrame):
    def __init__(self, index, text=None, pixmap=None, on_paste=None, on_delete=None):
        super().__init__()
        self.index = index
        self.text_content = text
        self.pixmap_content = pixmap
        self.on_paste = on_paste
        self.on_delete = on_delete

        self.setCursor(Qt.CursorShape.PointingHandCursor)
        self.setObjectName("card")
        self.setStyleSheet("""
            QFrame#card {
                background-color: #2b2b2b;
                border: 1px solid rgba(255, 255, 255, 0.08);
                border-radius: 8px;
            }
            QFrame#card:hover {
                background-color: #353535;
                border: 1px solid rgba(255, 255, 255, 0.16);
            }
        """)

        layout = QVBoxLayout(self)
        layout.setContentsMargins(12, 10, 12, 10)
        layout.setSpacing(6)

        # Header with actions
        top_layout = QHBoxLayout()
        top_layout.setContentsMargins(0, 0, 0, 0)
        top_layout.addStretch()

        del_btn = QPushButton("✕")
        del_btn.setFixedSize(20, 20)
        del_btn.setCursor(Qt.CursorShape.PointingHandCursor)
        del_btn.setStyleSheet("""
            QPushButton {
                background: transparent;
                color: #888888;
                border: none;
                font-size: 11px;
                font-weight: bold;
                border-radius: 4px;
            }
            QPushButton:hover {
                background: rgba(255, 255, 255, 0.12);
                color: #ffffff;
            }
        """)
        del_btn.clicked.connect(self._handle_delete)
        top_layout.addWidget(del_btn)
        layout.addLayout(top_layout)

        if self.pixmap_content:
            img_label = QLabel()
            scaled_pixmap = self.pixmap_content.scaled(
                320, 150,
                Qt.AspectRatioMode.KeepAspectRatio,
                Qt.TransformationMode.SmoothTransformation
            )
            img_label.setPixmap(scaled_pixmap)
            img_label.setAlignment(Qt.AlignmentFlag.AlignCenter)
            img_label.setStyleSheet("border-radius: 6px;")
            layout.addWidget(img_label)
        elif self.text_content:
            txt_label = QLabel(self.text_content[:260])
            txt_label.setWordWrap(True)
            txt_label.setStyleSheet("color: #f3f3f3; font-size: 13px; line-height: 1.4; border: none; background: transparent;")
            layout.addWidget(txt_label)

    def mousePressEvent(self, event):
        if event.button() == Qt.MouseButton.LeftButton:
            if self.on_paste:
                self.on_paste(self.index, self.text_content)
        super().mousePressEvent(event)

    def _handle_delete(self):
        if self.on_delete:
            self.on_delete(self.index)

class Win11ClipboardWindow(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowFlags(
            Qt.WindowType.FramelessWindowHint |
            Qt.WindowType.WindowStaysOnTopHint |
            Qt.WindowType.Tool
        )
        self.setAttribute(Qt.WidgetAttribute.WA_TranslucentBackground)
        self.resize(380, 540)
        self._init_ui()
        self._center_or_position()

    def _center_or_position(self):
        screen = QApplication.primaryScreen().geometry()
        # Position centered or near bottom taskbar (Windows 11 style)
        x = (screen.width() - self.width()) // 2
        y = screen.height() - self.height() - 70
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
        c_layout.setContentsMargins(14, 12, 14, 14)
        c_layout.setSpacing(10)

        # Top Tabs Row
        nav_layout = QHBoxLayout()
        nav_layout.setSpacing(4)

        self.tab_buttons = []
        tabs_info = [("📋", "Clipboard"), ("😊", "Emoji"), ("(^_^)", "Kaomoji"), ("Ω", "Symbols")]
        for idx, (icon_text, tooltip) in enumerate(tabs_info):
            btn = QPushButton(icon_text)
            btn.setFixedSize(36, 32)
            btn.setToolTip(tooltip)
            btn.setCursor(Qt.CursorShape.PointingHandCursor)
            btn.setStyleSheet(f"""
                QPushButton {{
                    background: {'rgba(255, 255, 255, 0.12)' if idx == 0 else 'transparent'};
                    color: #ffffff;
                    border: none;
                    border-radius: 6px;
                    font-size: {'14px' if len(icon_text) <= 2 else '11px'};
                }}
                QPushButton:hover {{
                    background: rgba(255, 255, 255, 0.18);
                }}
            """)
            btn.clicked.connect(lambda checked, i=idx: self.switch_tab(i))
            nav_layout.addWidget(btn)
            self.tab_buttons.append(btn)

        nav_layout.addStretch()

        # Clear All Button
        clear_btn = QPushButton("Clear all")
        clear_btn.setCursor(Qt.CursorShape.PointingHandCursor)
        clear_btn.setStyleSheet("""
            QPushButton {
                background: transparent;
                color: #60cdff;
                border: none;
                font-size: 12px;
                font-weight: 500;
                padding: 4px 8px;
                border-radius: 4px;
            }
            QPushButton:hover {
                background: rgba(96, 205, 255, 0.1);
            }
        """)
        clear_btn.clicked.connect(self.clear_all)
        nav_layout.addWidget(clear_btn)
        c_layout.addLayout(nav_layout)

        # Title & Search
        header_layout = QHBoxLayout()
        title_lbl = QLabel("Clipboard")
        title_lbl.setStyleSheet("color: #ffffff; font-size: 16px; font-weight: 600; border: none; background: transparent;")
        header_layout.addWidget(title_lbl)
        header_layout.addStretch()
        c_layout.addLayout(header_layout)

        # Stacked pages
        self.stack = QStackedWidget()
        c_layout.addWidget(self.stack)

        # Page 0: Clipboard History
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
        self.cards_layout.setContentsMargins(0, 0, 4, 0)
        self.cards_layout.setSpacing(8)
        self.cards_layout.addStretch()

        self.scroll.setWidget(self.cards_container)
        clip_layout.addWidget(self.scroll)
        self.stack.addWidget(self.clip_page)

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

        # Page 2: Kaomoji
        self.stack.addWidget(self._build_list_page([
            "(^_^)", "(•‿•)", "(◕‿◕)", "(づ｡◕‿‿◕｡)づ",
            "(╯°□°)╯︵ ┻━┻", "┬─┬ノ( º _ ºノ)", "¯\\_(ツ)_/¯",
            "( ͡° ͜ʖ ͡°)", "(¬‿¬)", "ಠ_ಠ", "(ง'̀-'́)ง",
            "(*^▽^*)", "(≧◡≦)", "(❤ω❤)", "(T_T)",
            "(;´༎ຶД༎ຶ`)", "(⊙_⊙)", "＼(＾O＾)／", "ヘ( ^o^)ノ"
        ]))

        # Page 3: Symbols
        self.stack.addWidget(self._build_grid_page([
            "$", "€", "£", "¥", "₺", "₽", "₩", "¢",
            "±", "×", "÷", "≠", "≈", "≤", "≥", "√", "∞", "π", "∑", "∆",
            "©", "®", "™", "°", "•", "★", "✓", "✗",
            "←", "→", "↑", "↓", "↔", "↕", "⇒", "⇔"
        ], font_size=16))

        self.load_history()

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
        grid.setContentsMargins(0, 0, 4, 0)
        grid.setSpacing(6)

        cols = 6
        for i, text in enumerate(items):
            btn = QPushButton(text)
            btn.setFixedSize(48, 44)
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
        l.setContentsMargins(0, 0, 4, 0)
        l.setSpacing(6)

        for text in items:
            btn = QPushButton(text)
            btn.setFixedHeight(38)
            btn.setCursor(Qt.CursorShape.PointingHandCursor)
            btn.setStyleSheet("""
                QPushButton {
                    background: #2b2b2b;
                    color: #ffffff;
                    border: 1px solid rgba(255, 255, 255, 0.08);
                    border-radius: 6px;
                    font-size: 13px;
                    padding-left: 12px;
                    text-align: left;
                }
                QPushButton:hover {
                    background: #383838;
                    border: 1px solid #60cdff;
                }
            """)
            btn.clicked.connect(lambda checked, t=text: self.paste_text(t))
            l.addWidget(btn)

        l.addStretch()
        scroll.setWidget(cont)
        layout.addWidget(scroll)
        return page

    def switch_tab(self, idx):
        self.stack.setCurrentIndex(idx)
        for i, btn in enumerate(self.tab_buttons):
            if i == idx:
                btn.setStyleSheet("""
                    QPushButton {
                        background: rgba(255, 255, 255, 0.14);
                        color: #ffffff;
                        border: none;
                        border-radius: 6px;
                    }
                """)
            else:
                btn.setStyleSheet("""
                    QPushButton {
                        background: transparent;
                        color: #ffffff;
                        border: none;
                        border-radius: 6px;
                    }
                    QPushButton:hover {
                        background: rgba(255, 255, 255, 0.18);
                    }
                """)

    def load_history(self):
        # Clear existing cards
        while self.cards_layout.count() > 1:
            child = self.cards_layout.takeAt(0)
            if child.widget():
                child.widget().deleteLater()

        try:
            count_out = subprocess.check_output(['copyq', 'count']).decode().strip()
            count = int(count_out or '0')
        except Exception:
            count = 0

        if count == 0:
            empty_lbl = QLabel("Nothing here\nYou'll see your clipboard history here once you've copied something.")
            empty_lbl.setAlignment(Qt.AlignmentFlag.AlignCenter)
            empty_lbl.setStyleSheet("color: #888888; font-size: 13px; padding-top: 60px;")
            self.cards_layout.insertWidget(0, empty_lbl)
            return

        for i in range(min(count, 40)):
            try:
                mimes = subprocess.check_output(['copyq', 'read', '?', str(i)]).decode('utf-8', errors='ignore')
                if 'image/png' in mimes:
                    img_data = subprocess.check_output(['copyq', 'read', 'image/png', str(i)])
                    img = QImage.fromData(img_data)
                    pixmap = QPixmap.fromImage(img)
                    card = ClipboardCard(i, pixmap=pixmap, on_paste=self.on_card_paste, on_delete=self.on_card_delete)
                    self.cards_layout.insertWidget(self.cards_layout.count() - 1, card)
                elif 'text/plain' in mimes:
                    text = subprocess.check_output(['copyq', 'read', 'text/plain', str(i)]).decode('utf-8', errors='replace').strip()
                    if text:
                        card = ClipboardCard(i, text=text, on_paste=self.on_card_paste, on_delete=self.on_card_delete)
                        self.cards_layout.insertWidget(self.cards_layout.count() - 1, card)
            except Exception:
                continue

    def on_card_paste(self, index, text):
        try:
            subprocess.run(['copyq', 'select', str(index)], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        except Exception:
            pass
        self.close()
        threading.Thread(target=paste_now, daemon=True).start()

    def paste_text(self, text):
        try:
            # Put text in clipboard
            p = subprocess.Popen(['wl-copy'], stdin=subprocess.PIPE)
            p.communicate(input=text.encode('utf-8'))
        except Exception:
            try:
                subprocess.run(['copyq', 'copy', text], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            except Exception:
                pass
        self.close()
        threading.Thread(target=paste_now, daemon=True).start()

    def on_card_delete(self, index):
        try:
            subprocess.run(['copyq', 'remove', str(index)], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            self.load_history()
        except Exception:
            pass

    def clear_all(self):
        try:
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
            if not self.isActiveWindow():
                self.close()
        super().changeEvent(event)

def main():
    # If already running toggle or launch
    lock_file = '/tmp/win11_clipboard.pid'
    if os.path.exists(lock_file):
        try:
            with open(lock_file, 'r') as f:
                pid = int(f.read().strip())
            os.kill(pid, 15) # SIGTERM closes it
            os.remove(lock_file)
            return
        except Exception:
            pass

    with open(lock_file, 'w') as f:
        f.write(str(os.getpid()))

    app = QApplication(sys.argv)
    app.setStyle("Fusion")
    win = Win11ClipboardWindow()
    win.show()

    ret = app.exec()
    if os.path.exists(lock_file):
        os.remove(lock_file)
    sys.exit(ret)

if __name__ == '__main__':
    main()
