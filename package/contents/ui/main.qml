import "search_db.js" as SearchDB
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.kirigami as Kirigami
import org.kde.plasma.private.kicker as Kicker
import org.kde.coreaddons as KCoreAddons
import org.kde.plasma.plasma5support as Plasma5Support

PlasmoidItem {
    id: root

    preferredRepresentation: compactRepresentation
    compactRepresentation: compactRepresentation
    fullRepresentation: compactRepresentation

    width: 820
    height: 700

    KCoreAddons.KUser {
        id: kuser
    }

    Kicker.RunnerModel {
        id: runnerModel
        appletInterface: root
    }

    // Full Application Model with Linux XDG Categories
    ListModel {
        id: fullAppsListModel
        ListElement { name: "Ark"; icon: "ark"; cmd: "ark"; category: "Utilities"; desc: "Archiving Tool"; desktop: "/usr/share/applications/org.kde.ark.desktop" }
        ListElement { name: "Brave Web Browser"; icon: "com.brave.Browser"; cmd: "flatpak run com.brave.Browser"; category: "Internet"; desc: "Fast & Secure Web Browser"; desktop: "/var/lib/flatpak/exports/share/applications/com.brave.Browser.desktop" }
        ListElement { name: "CMake"; icon: "CMakeSetup"; cmd: "cmake-gui"; category: "Development"; desc: "Cross-platform build system"; desktop: "/usr/share/applications/cmake-gui.desktop" }
        ListElement { name: "Crashed Processes Viewer"; icon: "tools-report-bug"; cmd: "drkonqi-coredump-gui"; category: "System"; desc: "Crash reports inspection"; desktop: "" }
        ListElement { name: "Discord"; icon: "discord"; cmd: "discord"; category: "Internet"; desc: "Voice and Text Chat"; desktop: "/usr/share/applications/discord.desktop" }
        ListElement { name: "Discover"; icon: "plasmadiscover"; cmd: "plasma-discover"; category: "System"; desc: "Software Center"; desktop: "/usr/share/applications/org.kde.discover.desktop" }
        ListElement { name: "Dolphin"; icon: "org.kde.dolphin"; cmd: "dolphin"; category: "System"; desc: "File Manager"; desktop: "/usr/share/applications/org.kde.dolphin.desktop" }
        ListElement { name: "Emoji Selector"; icon: "preferences-desktop-emoticons"; cmd: "plasma-emojier"; category: "Utilities"; desc: "Pick emoji characters"; desktop: "" }
        ListElement { name: "Hardware Locality lstopo"; icon: "hwloc"; cmd: "lstopo"; category: "System"; desc: "Hardware topology viewer"; desktop: "" }
        ListElement { name: "Htop"; icon: "htop"; cmd: "konsole -e htop"; category: "System"; desc: "Process Viewer"; desktop: "/usr/share/applications/htop.desktop" }
        ListElement { name: "Info Center"; icon: "hwinfo"; cmd: "kinfocenter"; category: "System"; desc: "Centralized system information"; desktop: "/usr/share/applications/org.kde.kinfocenter.desktop" }
        ListElement { name: "KDE System Settings"; icon: "preferences-system"; cmd: "systemsettings"; category: "Settings"; desc: "Configuration tools"; desktop: "/usr/share/applications/systemsettings.desktop" }
        ListElement { name: "Kitty"; icon: "kitty"; cmd: "kitty"; category: "System"; desc: "GPU-accelerated terminal"; desktop: "/usr/share/applications/kitty.desktop" }
        ListElement { name: "Konsole"; icon: "utilities-terminal"; cmd: "konsole"; category: "System"; desc: "Terminal Emulator"; desktop: "/usr/share/applications/org.kde.konsole.desktop" }
        ListElement { name: "Manage Printing"; icon: "cups"; cmd: "xdg-open http://localhost:631/"; category: "Settings"; desc: "CUPS Web Interface"; desktop: "/usr/share/applications/cups.desktop" }
        ListElement { name: "Menu Editor"; icon: "kmenuedit"; cmd: "kmenuedit"; category: "System"; desc: "Application launcher menu editor"; desktop: "/usr/share/applications/org.kde.kmenuedit.desktop" }
        ListElement { name: "Print Settings"; icon: "printer"; cmd: "system-config-printer"; category: "Settings"; desc: "Configure local printers"; desktop: "" }
        ListElement { name: "Qt Assistant"; icon: "assistant"; cmd: "assistant6"; category: "Development"; desc: "Qt documentation reader"; desktop: "/usr/share/applications/assistant.desktop" }
        ListElement { name: "Qt D-Bus Viewer"; icon: "qdbusviewer"; cmd: "qdbusviewer6"; category: "Development"; desc: "D-Bus introspection utility"; desktop: "" }
        ListElement { name: "Qt Linguist"; icon: "linguist"; cmd: "linguist6"; category: "Development"; desc: "Translation management tool"; desktop: "" }
        ListElement { name: "Qt V4L2 test Utility"; icon: "qv4l2"; cmd: "qv4l2"; category: "Multimedia"; desc: "Video test tool"; desktop: "" }
        ListElement { name: "Qt V4L2 video capture"; icon: "qvidcap"; cmd: "qvidcap"; category: "Multimedia"; desc: "Video capture utility"; desktop: "" }
        ListElement { name: "Qt Widgets Designer"; icon: "designer"; cmd: "designer6"; category: "Development"; desc: "GUI designer for Qt"; desktop: "/usr/share/applications/designer.desktop" }
        ListElement { name: "Rofi Application Launcher"; icon: "rofi"; cmd: "rofi -show drun"; category: "Utilities"; desc: "Window switcher & app launcher"; desktop: "/usr/share/applications/rofi.desktop" }
        ListElement { name: "Spectacle"; icon: "spectacle"; cmd: "spectacle"; category: "Utilities"; desc: "Screenshot Capture Utility"; desktop: "/usr/share/applications/org.kde.spectacle.desktop" }
        ListElement { name: "System Monitor"; icon: "utilities-system-monitor"; cmd: "plasma-systemmonitor"; category: "System"; desc: "View processes and system health"; desktop: "/usr/share/applications/org.kde.plasma-systemmonitor.desktop" }
        ListElement { name: "System Settings"; icon: "preferences-desktop-display-randr"; cmd: "systemsettings"; category: "Settings"; desc: "KDE plasma configuration"; desktop: "/usr/share/applications/systemsettings.desktop" }
        ListElement { name: "Vim Editor"; icon: "gvim"; cmd: "konsole -e vim"; category: "Utilities"; desc: "Advanced text editor"; desktop: "" }
        ListElement { name: "Visual Studio Code"; icon: "com.visualstudio.code"; cmd: "flatpak run com.visualstudio.code"; category: "Development"; desc: "Code editing redefined"; desktop: "/var/lib/flatpak/exports/share/applications/com.visualstudio.code.desktop" }
        ListElement { name: "VLC Media Player"; icon: "vlc"; cmd: "flatpak run org.videolan.VLC"; category: "Multimedia"; desc: "Open-source media player"; desktop: "/var/lib/flatpak/exports/share/applications/org.videolan.VLC.desktop" }
        ListElement { name: "Welcome Center"; icon: "start-here-kde-plasma"; cmd: "plasma-welcome"; category: "System"; desc: "KDE Plasma onboarding tour"; desktop: "" }
        ListElement { name: "Winetricks"; icon: "winetricks"; cmd: "winetricks --gui"; category: "Utilities"; desc: "Wine package helper"; desktop: "" }
    }

    Plasma5Support.DataSource {
        id: executableSource
        engine: "executable"
        connectedSources: []
        onNewData: function(sourceName, data) {
            disconnectSource(sourceName);
        }
        function exec(cmd) {
            connectSource(cmd);
        }
    }

    function launchCommand(cmd) {
        executableSource.exec(cmd);
        if (dialogWindow) dialogWindow.requestClose();
    }

    function openFolder(folderPath) {
        launchCommand("xdg-open '" + folderPath + "'");
    }

    function addToDesktop(name, icon, cmd, desktopFile) {
        var desktopPath = "/home/sir/Desktop/" + name.replace(/[^a-zA-Z0-9_-]/g, "_") + ".desktop";
        if (desktopFile && desktopFile.length > 0) {
            executableSource.exec("cp -f '" + desktopFile + "' '" + desktopPath + "' && chmod +x '" + desktopPath + "'");
        } else {
            var content = "[Desktop Entry]\\nVersion=1.0\\nType=Application\\nName=" + name + "\\nExec=" + cmd + "\\nIcon=" + icon + "\\nTerminal=false\\n";
            executableSource.exec("printf '" + content + "' > '" + desktopPath + "' && chmod +x '" + desktopPath + "'");
        }
    }

    function pinToTaskbar(desktopFile, name, cmd) {
        var baseFile = desktopFile;
        if (baseFile.indexOf("/") !== -1) {
            baseFile = baseFile.substring(baseFile.lastIndexOf("/") + 1);
        }
        var targetEntry = "applications:" + baseFile;
        var js = 'var ps = panels(); for (var i = 0; i < ps.length; i++) { var ws = ps[i].widgets(); for (var j = 0; j < ws.length; j++) { if (ws[j].type.indexOf("task") !== -1 || ws[j].type.indexOf("icontasks") !== -1) { ws[j].currentConfigGroup = ["General"]; var current = ws[j].readConfig("launchers"); var list = current ? current.split(",") : []; if (list.indexOf("' + targetEntry + '") === -1) { list.push("' + targetEntry + '"); ws[j].writeConfig("launchers", list); ws[j].reloadConfig(); } } } }';
        executableSource.exec("qdbus6 org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript '" + js + "'");
    }

    property QtObject dialogWindow: null

    Component.onCompleted: {
        dialogWindow = menuDialogComponent.createObject(root);
        plasmoid.activated.connect(function() {
            if (dialogWindow) dialogWindow.toggleMenu();
        });
    }

    // -------------------------------------------------------------
    // Compact Representation: Taskbar Start Button (Crystal Arch)
    // -------------------------------------------------------------
    Component {
        id: compactRepresentation
        Item {
            id: compactRoot
            implicitWidth: 44
            implicitHeight: 44

            Rectangle {
                anchors.centerIn: parent
                width: 38
                height: 38
                radius: 6
                color: compactMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.15) : "transparent"
                border.color: compactMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.2) : "transparent"

                Image {
                    anchors.centerIn: parent
                    width: 28
                    height: 28
                    source: Qt.resolvedUrl("Arch_Linux__Crystal__icon.svg")
                    sourceSize.width: 56
                    sourceSize.height: 56
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                }
            }

            MouseArea {
                id: compactMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    if (dialogWindow) {
                        dialogWindow.toggleMenu();
                    }
                }
            }
        }
    }

    // -------------------------------------------------------------
    // Dialog Window Positioned Exactly Above Taskbar (Windows 11 Docked)
    // -------------------------------------------------------------
    Component {
        id: menuDialogComponent

        PlasmaCore.Dialog {
            id: popDialog
            objectName: "win11Popup"
            flags: Qt.WindowStaysOnTopHint
            location: PlasmaCore.Types.Floating
            hideOnWindowDeactivate: !fullScope.isDraggingAny
            backgroundHints: PlasmaCore.Dialog.NoBackground

            width: 820
            height: 700

            property bool isClosing: false

            function resetState() {
                if (typeof powerMenu !== "undefined" && powerMenu) powerMenu.dismiss();
                if (typeof appContextMenu !== "undefined" && appContextMenu) appContextMenu.dismiss();
                searchInput.text = "";
                fullScope.showAllApps = false;
                fullScope.showMorePinned = false;
                allAppsContainer.selectedCategory = "All";
            }

            function openMenu() {
                if (closeAnim.running) {
                    closeAnim.stop();
                    resetState();
                }
                isClosing = false;
                visible = true;
                requestActivate();
                fullScope.forceActiveFocus();
                focusTimer.restart();
            }

            function requestClose() {
                if (typeof powerMenu !== "undefined" && powerMenu) powerMenu.dismiss();
                if (typeof appContextMenu !== "undefined" && appContextMenu) appContextMenu.dismiss();
                if (!visible || isClosing) return;
                isClosing = true;
                if (openAnim.running) openAnim.stop();
                closeAnim.restart();
            }

            function toggleMenu() {
                if (visible && !isClosing) {
                    requestClose();
                } else {
                    openMenu();
                }
            }

            onVisibleChanged: {
                if (visible) {
                    isClosing = false;
                    var screen = root.screenGeometry;
                    var appletGlobal = root.mapToGlobal(0, 0);

                    // Position X: Centered with 10px shift to the right
                    var targetX = screen.x + (screen.width - width) / 2 + 10;

                    // Position Y: Exactly above the bottom panel with 5px margin
                    var targetY = appletGlobal.y - height - 5;
                    if (targetY < screen.y + 12) targetY = screen.y + 12;

                    x = targetX;
                    y = targetY;

                    // Straight vertical 140ms opening animation
                    containerRect.opacity = 0.0;
                    menuTranslate.y = 20;
                    openAnim.restart();
                } else {
                    if (typeof powerMenu !== "undefined" && powerMenu) powerMenu.dismiss();
                    if (typeof appContextMenu !== "undefined" && appContextMenu) appContextMenu.dismiss();
                    openAnim.stop();
                    closeAnim.stop();
                    isClosing = false;
                    containerRect.opacity = 1.0;
                    menuTranslate.y = 0;
                }
            }

            mainItem: FocusScope {
                id: fullScope
                width: 820
                height: 700
                focus: true

                property bool showAllApps: false
                property bool isSearching: searchInput.text.trim().length > 0
                property bool showMorePinned: false
                property bool isDraggingAny: false

                // Instant Multi-Category Search Models
                ListModel { id: searchAppsModel }
                ListModel { id: searchFilesModel }
                ListModel { id: searchToolsModel }
                property string activeSearchFilter: "All"
                property var selectedSearchItem: null

                function performInstantSearch(query) {
                    var q = query.trim().toLowerCase();
                    searchAppsModel.clear();
                    searchFilesModel.clear();
                    searchToolsModel.clear();
                    selectedSearchItem = null;

                    if (q.length === 0) return;

                    var apps = SearchDB.searchDb.apps || [];
                    for (var i = 0; i < apps.length; i++) {
                        var a = apps[i];
                        if (a.name.toLowerCase().indexOf(q) !== -1 || a.desc.toLowerCase().indexOf(q) !== -1 || a.category.toLowerCase().indexOf(q) !== -1) {
                            searchAppsModel.append(a);
                            if (!selectedSearchItem) selectedSearchItem = a;
                        }
                    }

                    var files = SearchDB.searchDb.files || [];
                    for (var j = 0; j < files.length; j++) {
                        var fl = files[j];
                        if (fl.name.toLowerCase().indexOf(q) !== -1 || fl.desc.toLowerCase().indexOf(q) !== -1 || fl.location.toLowerCase().indexOf(q) !== -1) {
                            searchFilesModel.append(fl);
                            if (!selectedSearchItem) selectedSearchItem = fl;
                        }
                    }

                    var tools = SearchDB.searchDb.tools || [];
                    for (var k = 0; k < tools.length; k++) {
                        var t = tools[k];
                        if (t.name.toLowerCase().indexOf(q) !== -1 || t.desc.toLowerCase().indexOf(q) !== -1 || t.category.toLowerCase().indexOf(q) !== -1) {
                            searchToolsModel.append(t);
                            if (!selectedSearchItem) selectedSearchItem = t;
                        }
                    }
                }


                Keys.onEscapePressed: popDialog.requestClose()

                // Catch any typing anywhere in the menu and route directly to searchInput
                Keys.onPressed: function(event) {
                    if (event.key === Qt.Key_Escape) {
                        popDialog.requestClose();
                        event.accepted = true;
                    } else if (!searchInput.activeFocus && event.text.length > 0 && event.key !== Qt.Key_Tab && event.key !== Qt.Key_Backtab) {
                        searchInput.forceActiveFocus();
                        searchInput.text += event.text;
                        searchInput.cursorPosition = searchInput.text.length;
                        event.accepted = true;
                    }
                }

                Timer {
                    id: focusTimer
                    interval: 30
                    repeat: false
                    onTriggered: {
                        searchInput.forceActiveFocus();
                        searchInput.selectAll();
                    }
                }

                onVisibleChanged: {
                    if (visible) {
                        popDialog.requestActivate();
                        focusTimer.restart();
                    }
                }

                // Sharper & Snappier Windows 11 Opening Animation (Rise Straight Up, 110ms with Quartic curve)
                ParallelAnimation {
                    id: openAnim
                    NumberAnimation {
                        target: containerRect
                        property: "opacity"
                        from: 0.0
                        to: 1.0
                        duration: 110
                        easing.type: Easing.OutQuart
                    }
                    NumberAnimation {
                        target: menuTranslate
                        property: "y"
                        from: 14
                        to: 0
                        duration: 110
                        easing.type: Easing.OutQuart
                    }
                }

                // Sharper & Snappier Windows 11 Closing Animation (Descend Straight Down, 80ms)
                ParallelAnimation {
                    id: closeAnim
                    NumberAnimation {
                        target: containerRect
                        property: "opacity"
                        from: containerRect.opacity
                        to: 0.0
                        duration: 80
                        easing.type: Easing.InQuart
                    }
                    NumberAnimation {
                        target: menuTranslate
                        property: "y"
                        from: menuTranslate.y
                        to: 12
                        duration: 80
                        easing.type: Easing.InQuart
                    }
                    onFinished: {
                        popDialog.visible = false;
                        popDialog.isClosing = false;
                        popDialog.resetState();
                    }
                }

                // Windows 11 App Context Menu (Right Click on Apps)
                property var contextTargetApp: null

                QQC2.Menu {
                    id: appContextMenu

                    QQC2.MenuItem {
                        text: "Open"
                        icon.name: "system-run"
                        onTriggered: {
                            if (fullScope.contextTargetApp) {
                                root.launchCommand(fullScope.contextTargetApp.cmd);
                            }
                        }
                    }

                    QQC2.MenuSeparator {}

                    QQC2.MenuItem {
                        text: (fullScope.contextTargetApp && fullScope.contextTargetApp.isPinned) ? "Unpin from Start" : "Pin to Start"
                        icon.name: "favorite"
                        onTriggered: {
                            if (fullScope.contextTargetApp) {
                                if (fullScope.contextTargetApp.isPinned) {
                                    // Remove from pinned
                                    for (var i = 0; i < pinnedFullModel.count; i++) {
                                        if (pinnedFullModel.get(i).name === fullScope.contextTargetApp.name) {
                                            pinnedFullModel.remove(i);
                                            break;
                                        }
                                    }
                                } else {
                                    // Add to pinned
                                    pinnedFullModel.append({
                                        name: fullScope.contextTargetApp.name,
                                        icon: fullScope.contextTargetApp.icon,
                                        cmd: fullScope.contextTargetApp.cmd,
                                        extra: false,
                                        desktop: fullScope.contextTargetApp.desktop || ""
                                    });
                                }
                            }
                        }
                    }

                    QQC2.MenuItem {
                        text: "Pin to Taskbar"
                        icon.name: "list-add"
                        onTriggered: {
                            if (fullScope.contextTargetApp) {
                                root.pinToTaskbar(fullScope.contextTargetApp.desktop, fullScope.contextTargetApp.name, fullScope.contextTargetApp.cmd);
                            }
                        }
                    }

                    QQC2.MenuItem {
                        text: "Add to Desktop"
                        icon.name: "user-desktop"
                        onTriggered: {
                            if (fullScope.contextTargetApp) {
                                root.addToDesktop(fullScope.contextTargetApp.name, fullScope.contextTargetApp.icon, fullScope.contextTargetApp.cmd, fullScope.contextTargetApp.desktop);
                            }
                        }
                    }
                }

                // Power Options Menu
                QQC2.Menu {
                    id: powerMenu
                    QQC2.MenuItem {
                        text: "Lock Screen"
                        icon.name: "system-lock-screen"
                        onTriggered: root.launchCommand("loginctl lock-session")
                    }
                    QQC2.MenuItem {
                        text: "Log Out"
                        icon.name: "system-log-out"
                        onTriggered: root.launchCommand("qdbus6 org.kde.Shutdown /Shutdown org.kde.Shutdown.logout")
                    }
                    QQC2.MenuItem {
                        text: "Sleep (Suspend)"
                        icon.name: "system-suspend"
                        onTriggered: root.launchCommand("systemctl suspend")
                    }
                    QQC2.MenuItem {
                        text: "Restart"
                        icon.name: "system-reboot"
                        onTriggered: root.launchCommand("systemctl reboot")
                    }
                    QQC2.MenuItem {
                        text: "Shut Down"
                        icon.name: "system-shutdown"
                        onTriggered: root.launchCommand("systemctl poweroff")
                    }
                }

                // Main Outer Glass Container (Dark Semi-Transparent with Glass Border)
                Rectangle {
                    id: containerRect
                    anchors.fill: parent
                    radius: 16
                    color: Qt.rgba(0.086, 0.106, 0.149, 0.88)
                    border.width: 1
                    border.color: Qt.rgba(1, 1, 1, 0.18)

                    transform: [
                        Translate { id: menuTranslate; y: 0 }
                    ]

                    ColumnLayout {
                        anchors.fill: parent
                        spacing: 0

                        // -----------------------------------------------------
                        // 1. TOP ROUNDED SEARCH BAR
                        // -----------------------------------------------------
                        Item {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 74
                            Layout.leftMargin: 24
                            Layout.rightMargin: 24

                            Rectangle {
                                anchors.centerIn: parent
                                width: parent.width
                                height: 44
                                radius: 22
                                color: searchInput.activeFocus ? Qt.rgba(1, 1, 1, 0.12) : Qt.rgba(1, 1, 1, 0.07)
                                border.width: 1
                                border.color: searchInput.activeFocus ? "#0084ff" : Qt.rgba(1, 1, 1, 0.18)

                                RowLayout {
                                    anchors.fill: parent
                                    anchors.leftMargin: 18
                                    anchors.rightMargin: 16
                                    spacing: 12

                                    Kirigami.Icon {
                                        source: "edit-find"
                                        Layout.preferredWidth: 18
                                        Layout.preferredHeight: 18
                                        opacity: 0.8
                                    }

                                    QQC2.TextField {
                                        id: searchInput
                                        Layout.fillWidth: true
                                        Layout.fillHeight: true
                                        placeholderText: "Type here to search apps, files and settings..."
                                        placeholderTextColor: "#a2abbd"
                                        color: "white"
                                        font.pixelSize: 14
                                        font.family: "Segoe UI"
                                        background: Item {}
                                        onTextChanged: {
                                            fullScope.performInstantSearch(text);
                                            runnerModel.query = text;
                                        }
                                        Keys.onReturnPressed: {
                                            if (fullScope.selectedSearchItem) {
                                                root.launchCommand(fullScope.selectedSearchItem.cmd);
                                                popDialog.requestClose();
                                            } else if (runnerModel.count > 0) {
                                                runnerModel.trigger(0, "", null);
                                                popDialog.requestClose();
                                            }
                                        }
                                    }

                                    QQC2.ToolButton {
                                        visible: searchInput.text.length > 0
                                        icon.name: "edit-clear"
                                        onClicked: searchInput.text = ""
                                    }
                                }
                            }
                        }

                        // -----------------------------------------------------
                        // 2. MAIN TWO-COLUMN BODY
                        // -----------------------------------------------------
                        RowLayout {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            spacing: 0

                            // LEFT SECTION: Pinned (5-col) & Recommended
                            Item {
                                Layout.fillWidth: true
                                Layout.fillHeight: true

                                // Vertical Divider Line
                                Rectangle {
                                    anchors.right: parent.right
                                    anchors.top: parent.top
                                    anchors.bottom: parent.bottom
                                    width: 1
                                    color: Qt.rgba(1, 1, 1, 0.1)
                                }

                                // Windows 11 Full 3-Column Search Results View (Apps, Files, Tools) + Live Instant Preview
                                Item {
                                    anchors.fill: parent
                                    anchors.leftMargin: 20
                                    anchors.rightMargin: 20
                                    visible: fullScope.isSearching

                                    ColumnLayout {
                                        anchors.fill: parent
                                        spacing: 10

                                        // Category Filter Chips (All, Apps, Files, Tools)
                                        RowLayout {
                                            Layout.fillWidth: true
                                            spacing: 6

                                            Repeater {
                                                model: ["All", "Apps", "Files", "Tools"]
                                                Rectangle {
                                                    required property string modelData
                                                    height: 24
                                                    radius: 12
                                                    width: filterChipText.implicitWidth + 20
                                                    color: fullScope.activeSearchFilter === modelData ? "#0078d4" : (chipHover.containsMouse ? Qt.rgba(1, 1, 1, 0.14) : Qt.rgba(1, 1, 1, 0.07))
                                                    border.color: fullScope.activeSearchFilter === modelData ? "#2d9aff" : Qt.rgba(1, 1, 1, 0.15)

                                                    Text {
                                                        id: filterChipText
                                                        anchors.centerIn: parent
                                                        text: parent.modelData
                                                        color: "white"
                                                        font.pixelSize: 11
                                                        font.weight: fullScope.activeSearchFilter === parent.modelData ? Font.DemiBold : Font.Normal
                                                    }

                                                    MouseArea {
                                                        id: chipHover
                                                        anchors.fill: parent
                                                        hoverEnabled: true
                                                        cursorShape: Qt.PointingHandCursor
                                                        onClicked: fullScope.activeSearchFilter = parent.modelData
                                                    }
                                                }
                                            }
                                            Item { Layout.fillWidth: true }
                                        }

                                        // 3-Column Split or Multi-Category Grid
                                        RowLayout {
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true
                                            spacing: 12

                                            // Column 1: Applications (Apps)
                                            ColumnLayout {
                                                Layout.fillWidth: true
                                                Layout.fillHeight: true
                                                Layout.preferredWidth: 1
                                                visible: fullScope.activeSearchFilter === "All" || fullScope.activeSearchFilter === "Apps"
                                                spacing: 6

                                                RowLayout {
                                                    Layout.fillWidth: true
                                                    Text {
                                                        text: "APPS (" + searchAppsModel.count + ")"
                                                        color: "#79c0ff"
                                                        font.pixelSize: 10
                                                        font.weight: Font.Bold
                                                    }
                                                }

                                                ListView {
                                                    Layout.fillWidth: true
                                                    Layout.fillHeight: true
                                                    clip: true
                                                    model: searchAppsModel
                                                    spacing: 4
                                                    delegate: Rectangle {
                                                        width: ListView.view.width
                                                        height: 40
                                                        radius: 6
                                                        color: (fullScope.selectedSearchItem && fullScope.selectedSearchItem.name === model.name) ? Qt.rgba(0, 0.47, 0.83, 0.35) : (appItemMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.1) : "transparent")
                                                        border.color: (fullScope.selectedSearchItem && fullScope.selectedSearchItem.name === model.name) ? "#0078d4" : "transparent"

                                                        RowLayout {
                                                            anchors.fill: parent
                                                            anchors.leftMargin: 8
                                                            anchors.rightMargin: 8
                                                            spacing: 8

                                                            Kirigami.Icon {
                                                                source: model.icon || "application-x-executable"
                                                                Layout.preferredWidth: 22
                                                                Layout.preferredHeight: 22
                                                            }
                                                            ColumnLayout {
                                                                Layout.fillWidth: true
                                                                spacing: 1
                                                                Text {
                                                                    text: model.name
                                                                    color: "white"
                                                                    font.pixelSize: 11
                                                                    font.weight: Font.Medium
                                                                    elide: Text.ElideRight
                                                                    Layout.fillWidth: true
                                                                }
                                                                Text {
                                                                    text: model.desc
                                                                    color: "#9aa3b2"
                                                                    font.pixelSize: 9
                                                                    elide: Text.ElideRight
                                                                    Layout.fillWidth: true
                                                                }
                                                            }
                                                        }

                                                        MouseArea {
                                                            id: appItemMouse
                                                            anchors.fill: parent
                                                            hoverEnabled: true
                                                            cursorShape: Qt.PointingHandCursor
                                                            onEntered: fullScope.selectedSearchItem = model
                                                            onClicked: {
                                                                root.launchCommand(model.cmd);
                                                                popDialog.requestClose();
                                                            }
                                                        }
                                                    }
                                                }
                                            }

                                            // Column 2: Files & Documents
                                            ColumnLayout {
                                                Layout.fillWidth: true
                                                Layout.fillHeight: true
                                                Layout.preferredWidth: 1
                                                visible: fullScope.activeSearchFilter === "All" || fullScope.activeSearchFilter === "Files"
                                                spacing: 6

                                                RowLayout {
                                                    Layout.fillWidth: true
                                                    Text {
                                                        text: "FILES (" + searchFilesModel.count + ")"
                                                        color: "#7ee787"
                                                        font.pixelSize: 10
                                                        font.weight: Font.Bold
                                                    }
                                                }

                                                ListView {
                                                    Layout.fillWidth: true
                                                    Layout.fillHeight: true
                                                    clip: true
                                                    model: searchFilesModel
                                                    spacing: 4
                                                    delegate: Rectangle {
                                                        width: ListView.view.width
                                                        height: 40
                                                        radius: 6
                                                        color: (fullScope.selectedSearchItem && fullScope.selectedSearchItem.name === model.name) ? Qt.rgba(0, 0.47, 0.83, 0.35) : (fileItemMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.1) : "transparent")
                                                        border.color: (fullScope.selectedSearchItem && fullScope.selectedSearchItem.name === model.name) ? "#0078d4" : "transparent"

                                                        RowLayout {
                                                            anchors.fill: parent
                                                            anchors.leftMargin: 8
                                                            anchors.rightMargin: 8
                                                            spacing: 8

                                                            Kirigami.Icon {
                                                                source: model.icon || "text-plain"
                                                                Layout.preferredWidth: 22
                                                                Layout.preferredHeight: 22
                                                            }
                                                            ColumnLayout {
                                                                Layout.fillWidth: true
                                                                spacing: 1
                                                                Text {
                                                                    text: model.name
                                                                    color: "white"
                                                                    font.pixelSize: 11
                                                                    font.weight: Font.Medium
                                                                    elide: Text.ElideRight
                                                                    Layout.fillWidth: true
                                                                }
                                                                Text {
                                                                    text: model.desc
                                                                    color: "#9aa3b2"
                                                                    font.pixelSize: 9
                                                                    elide: Text.ElideRight
                                                                    Layout.fillWidth: true
                                                                }
                                                            }
                                                        }

                                                        MouseArea {
                                                            id: fileItemMouse
                                                            anchors.fill: parent
                                                            hoverEnabled: true
                                                            cursorShape: Qt.PointingHandCursor
                                                            onEntered: fullScope.selectedSearchItem = model
                                                            onClicked: {
                                                                root.launchCommand(model.cmd);
                                                                popDialog.requestClose();
                                                            }
                                                        }
                                                    }
                                                }
                                            }

                                            // Column 3: Tools & Settings
                                            ColumnLayout {
                                                Layout.fillWidth: true
                                                Layout.fillHeight: true
                                                Layout.preferredWidth: 1
                                                visible: fullScope.activeSearchFilter === "All" || fullScope.activeSearchFilter === "Tools"
                                                spacing: 6

                                                RowLayout {
                                                    Layout.fillWidth: true
                                                    Text {
                                                        text: "TOOLS (" + searchToolsModel.count + ")"
                                                        color: "#d2a8ff"
                                                        font.pixelSize: 10
                                                        font.weight: Font.Bold
                                                    }
                                                }

                                                ListView {
                                                    Layout.fillWidth: true
                                                    Layout.fillHeight: true
                                                    clip: true
                                                    model: searchToolsModel
                                                    spacing: 4
                                                    delegate: Rectangle {
                                                        width: ListView.view.width
                                                        height: 40
                                                        radius: 6
                                                        color: (fullScope.selectedSearchItem && fullScope.selectedSearchItem.name === model.name) ? Qt.rgba(0, 0.47, 0.83, 0.35) : (toolItemMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.1) : "transparent")
                                                        border.color: (fullScope.selectedSearchItem && fullScope.selectedSearchItem.name === model.name) ? "#0078d4" : "transparent"

                                                        RowLayout {
                                                            anchors.fill: parent
                                                            anchors.leftMargin: 8
                                                            anchors.rightMargin: 8
                                                            spacing: 8

                                                            Kirigami.Icon {
                                                                source: model.icon || "preferences-system"
                                                                Layout.preferredWidth: 22
                                                                Layout.preferredHeight: 22
                                                            }
                                                            ColumnLayout {
                                                                Layout.fillWidth: true
                                                                spacing: 1
                                                                Text {
                                                                    text: model.name
                                                                    color: "white"
                                                                    font.pixelSize: 11
                                                                    font.weight: Font.Medium
                                                                    elide: Text.ElideRight
                                                                    Layout.fillWidth: true
                                                                }
                                                                Text {
                                                                    text: model.desc
                                                                    color: "#9aa3b2"
                                                                    font.pixelSize: 9
                                                                    elide: Text.ElideRight
                                                                    Layout.fillWidth: true
                                                                }
                                                            }
                                                        }

                                                        MouseArea {
                                                            id: toolItemMouse
                                                            anchors.fill: parent
                                                            hoverEnabled: true
                                                            cursorShape: Qt.PointingHandCursor
                                                            onEntered: fullScope.selectedSearchItem = model
                                                            onClicked: {
                                                                root.launchCommand(model.cmd);
                                                                popDialog.requestClose();
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }

                                // All Apps View with Linux Categories
                                ColumnLayout {
                                    anchors.fill: parent
                                    anchors.leftMargin: 24
                                    anchors.rightMargin: 20
                                    visible: !fullScope.isSearching && fullScope.showAllApps
                                    spacing: 8

                                    RowLayout {
                                        Layout.fillWidth: true
                                        Text {
                                            text: "All Applications"
                                            color: "white"
                                            font.pixelSize: 13
                                            font.weight: Font.DemiBold
                                        }
                                        Item { Layout.fillWidth: true }
                                        Rectangle {
                                            width: 75
                                            height: 26
                                            radius: 6
                                            color: allBackMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.18) : Qt.rgba(1, 1, 1, 0.08)
                                            border.color: Qt.rgba(1, 1, 1, 0.15)
                                            Text {
                                                anchors.centerIn: parent
                                                text: "< Back"
                                                color: "white"
                                                font.pixelSize: 12
                                            }
                                            MouseArea {
                                                id: allBackMouse
                                                anchors.fill: parent
                                                hoverEnabled: true
                                                cursorShape: Qt.PointingHandCursor
                                                onClicked: fullScope.showAllApps = false
                                            }
                                        }
                                    }

                                    // Linux Categories Filter Chips
                                    property string selectedCategory: "All"
                                    id: allAppsContainer

                                    Flickable {
                                        Layout.fillWidth: true
                                        Layout.preferredHeight: 32
                                        contentWidth: chipsRow.implicitWidth
                                        contentHeight: 32
                                        clip: true
                                        boundsBehavior: Flickable.StopAtBounds

                                        RowLayout {
                                            id: chipsRow
                                            spacing: 6
                                            Repeater {
                                                model: [
                                                    { name: "All", cat: "All" },
                                                    { name: "Development", cat: "Development" },
                                                    { name: "Internet", cat: "Internet" },
                                                    { name: "Multimedia", cat: "Multimedia" },
                                                    { name: "System", cat: "System" },
                                                    { name: "Utilities", cat: "Utilities" },
                                                    { name: "Settings", cat: "Settings" }
                                                ]
                                                delegate: Rectangle {
                                                    height: 26
                                                    width: catText.implicitWidth + 18
                                                    radius: 13
                                                    color: allAppsContainer.selectedCategory === modelData.cat ? Qt.rgba(0.2, 0.5, 0.9, 0.4) : (catChipMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.12) : Qt.rgba(1, 1, 1, 0.06))
                                                    border.color: allAppsContainer.selectedCategory === modelData.cat ? "#38bdf8" : Qt.rgba(1, 1, 1, 0.12)

                                                    Text {
                                                        id: catText
                                                        anchors.centerIn: parent
                                                        text: modelData.name
                                                        color: allAppsContainer.selectedCategory === modelData.cat ? "#38bdf8" : "white"
                                                        font.pixelSize: 11
                                                        font.weight: allAppsContainer.selectedCategory === modelData.cat ? Font.DemiBold : Font.Normal
                                                    }

                                                    MouseArea {
                                                        id: catChipMouse
                                                        anchors.fill: parent
                                                        hoverEnabled: true
                                                        cursorShape: Qt.PointingHandCursor
                                                        onClicked: allAppsContainer.selectedCategory = modelData.cat
                                                    }
                                                }
                                            }
                                        }
                                    }

                                    // Categorized & Native Apps List (Windows 11 Clean List View)
                                    ListView {
                                        id: allAppsListView
                                        Layout.fillWidth: true
                                        Layout.fillHeight: true
                                        clip: true
                                        spacing: 2
                                        model: fullAppsListModel

                                        delegate: Rectangle {
                                            width: ListView.view.width
                                            height: (allAppsContainer.selectedCategory === "All" || model.category.indexOf(allAppsContainer.selectedCategory) !== -1) ? 44 : 0
                                            visible: height > 0
                                            radius: 6
                                            color: aMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.12) : "transparent"
                                            border.color: aMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.16) : "transparent"

                                            RowLayout {
                                                anchors.fill: parent
                                                anchors.leftMargin: 10
                                                anchors.rightMargin: 10
                                                spacing: 12
                                                visible: parent.visible

                                                Kirigami.Icon {
                                                    source: model.icon || "application-x-executable"
                                                    Layout.preferredWidth: 26
                                                    Layout.preferredHeight: 26
                                                }

                                                ColumnLayout {
                                                    Layout.fillWidth: true
                                                    spacing: 1
                                                    Text {
                                                        text: model.name
                                                        color: "white"
                                                        font.pixelSize: 12
                                                        font.weight: Font.Medium
                                                        elide: Text.ElideRight
                                                        Layout.fillWidth: true
                                                    }
                                                    Text {
                                                        text: model.desc + (allAppsContainer.selectedCategory === "All" ? " • " + model.category : "")
                                                        color: "#a2abbd"
                                                        font.pixelSize: 10
                                                        elide: Text.ElideRight
                                                        Layout.fillWidth: true
                                                    }
                                                }
                                            }

                                            MouseArea {
                                                id: aMouse
                                                anchors.fill: parent
                                                hoverEnabled: true
                                                acceptedButtons: Qt.LeftButton | Qt.RightButton
                                                cursorShape: Qt.PointingHandCursor
                                                onClicked: function(mouse) {
                                                    if (mouse.button === Qt.RightButton) {
                                                        fullScope.contextTargetApp = {
                                                            name: model.name,
                                                            icon: model.icon,
                                                            cmd: model.cmd,
                                                            desktop: model.desktop,
                                                            isPinned: false
                                                        };
                                                        // check if already pinned
                                                        for (var i = 0; i < pinnedFullModel.count; i++) {
                                                            if (pinnedFullModel.get(i).name === model.name) {
                                                                fullScope.contextTargetApp.isPinned = true;
                                                                break;
                                                            }
                                                        }
                                                        appContextMenu.popup();
                                                    } else {
                                                        root.launchCommand(model.cmd);
                                                        popDialog.requestClose();
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }

                                // Pinned (5-col) & Recommended Default View
                                ColumnLayout {
                                    anchors.fill: parent
                                    anchors.leftMargin: 24
                                    anchors.rightMargin: 20
                                    visible: !fullScope.isSearching && !fullScope.showAllApps
                                    spacing: 16

                                    // Pinned Header
                                    RowLayout {
                                        Layout.fillWidth: true
                                        Text {
                                            text: "Pinned"
                                            color: "white"
                                            font.pixelSize: 13
                                            font.weight: Font.DemiBold
                                        }
                                        Item { Layout.fillWidth: true }
                                        Rectangle {
                                            width: 86
                                            height: 26
                                            radius: 6
                                            color: allAppsBtnMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.18) : Qt.rgba(1, 1, 1, 0.08)
                                            border.color: Qt.rgba(1, 1, 1, 0.15)
                                            Text {
                                                anchors.centerIn: parent
                                                text: "All Apps >"
                                                color: "white"
                                                font.pixelSize: 12
                                            }
                                            MouseArea {
                                                id: allAppsBtnMouse
                                                anchors.fill: parent
                                                hoverEnabled: true
                                                cursorShape: Qt.PointingHandCursor
                                                onClicked: fullScope.showAllApps = true
                                            }
                                        }
                                    }

                                    // Pinned 6-Column Grid (Expands from 2 rows to 3 rows when More is clicked)
                                    GridLayout {
                                        Layout.fillWidth: true
                                        columns: 6
                                        rowSpacing: 10
                                        columnSpacing: 6

                                        Repeater {
                                            model: ListModel {
                                                id: pinnedFullModel
                                                // Row 1
                                                ListElement { name: "Dolphin"; icon: "org.kde.dolphin"; cmd: "dolphin"; extra: false; desktop: "/usr/share/applications/org.kde.dolphin.desktop" }
                                                ListElement { name: "Konsole"; icon: "utilities-terminal"; cmd: "konsole"; extra: false; desktop: "/usr/share/applications/org.kde.konsole.desktop" }
                                                ListElement { name: "Kitty"; icon: "kitty"; cmd: "kitty"; extra: false; desktop: "/usr/share/applications/kitty.desktop" }
                                                ListElement { name: "Settings"; icon: "systemsettings"; cmd: "systemsettings"; extra: false; desktop: "/usr/share/applications/systemsettings.desktop" }
                                                ListElement { name: "Discover"; icon: "plasmadiscover"; cmd: "plasma-discover"; extra: false; desktop: "/usr/share/applications/org.kde.discover.desktop" }
                                                ListElement { name: "Brave"; icon: "com.brave.Browser"; cmd: "flatpak run com.brave.Browser"; extra: false; desktop: "/var/lib/flatpak/exports/share/applications/com.brave.Browser.desktop" }
                                                // Row 2
                                                ListElement { name: "Discord"; icon: "discord"; cmd: "discord"; extra: false; desktop: "/usr/share/applications/discord.desktop" }
                                                ListElement { name: "Spectacle"; icon: "spectacle"; cmd: "spectacle"; extra: false; desktop: "/usr/share/applications/org.kde.spectacle.desktop" }
                                                ListElement { name: "Calculator"; icon: "accessories-calculator"; cmd: "kcalc"; extra: false; desktop: "" }
                                                ListElement { name: "Text Editor"; icon: "accessories-text-editor"; cmd: "kate"; extra: false; desktop: "" }
                                                ListElement { name: "About KDE"; icon: "kde"; cmd: "kinfocenter"; extra: false; desktop: "/usr/share/applications/org.kde.kinfocenter.desktop" }
                                                ListElement { name: "System Monitor"; icon: "utilities-system-monitor"; cmd: "plasma-systemmonitor"; extra: false; desktop: "/usr/share/applications/org.kde.plasma-systemmonitor.desktop" }
                                                // Row 3 (Extra Row appearing when More is clicked)
                                                ListElement { name: "VS Code"; icon: "com.visualstudio.code"; cmd: "flatpak run com.visualstudio.code"; extra: true; desktop: "/var/lib/flatpak/exports/share/applications/com.visualstudio.code.desktop" }
                                                ListElement { name: "VLC Player"; icon: "vlc"; cmd: "flatpak run org.videolan.VLC"; extra: true; desktop: "/var/lib/flatpak/exports/share/applications/org.videolan.VLC.desktop" }
                                                ListElement { name: "Htop Monitor"; icon: "htop"; cmd: "konsole -e htop"; extra: true; desktop: "/usr/share/applications/htop.desktop" }
                                                ListElement { name: "Ark Archive"; icon: "org.kde.ark"; cmd: "ark"; extra: true; desktop: "/usr/share/applications/org.kde.ark.desktop" }
                                                ListElement { name: "Rofi Launcher"; icon: "rofi"; cmd: "rofi -show drun"; extra: true; desktop: "/usr/share/applications/rofi.desktop" }
                                                ListElement { name: "Info Center"; icon: "hwinfo"; cmd: "kinfocenter"; extra: true; desktop: "/usr/share/applications/org.kde.kinfocenter.desktop" }
                                            }

                                            delegate: Item {
                                                id: pinDelegateRoot
                                                visible: !model.extra || fullScope.showMorePinned
                                                Layout.preferredWidth: 92
                                                Layout.preferredHeight: 86

                                                property int itemIndex: index
                                                property bool isDragging: dragArea.drag.active

                                                DropArea {
                                                    id: pinDropArea
                                                    anchors.fill: parent
                                                    keys: ["application/x-pin-item"]

                                                    onEntered: function(drag) {
                                                        var sourceIdx = drag.source.itemIndex;
                                                        if (sourceIdx !== undefined && sourceIdx !== pinDelegateRoot.itemIndex) {
                                                            pinnedFullModel.move(sourceIdx, pinDelegateRoot.itemIndex, 1);
                                                        }
                                                    }
                                                }

                                                Rectangle {
                                                    id: pinVisual
                                                    width: 92
                                                    height: 86
                                                    radius: 8
                                                    color: (dragArea.drag.active) ? Qt.rgba(0.2, 0.5, 0.9, 0.3) : (dragArea.containsMouse ? Qt.rgba(1, 1, 1, 0.1) : "transparent")
                                                    border.color: (dragArea.drag.active) ? "#38bdf8" : (dragArea.containsMouse ? Qt.rgba(1, 1, 1, 0.15) : "transparent")
                                                    z: dragArea.drag.active ? 100 : 1
                                                    scale: dragArea.drag.active ? 1.08 : 1.0

                                                    Drag.active: dragArea.drag.active
                                                    Drag.source: pinDelegateRoot
                                                    Drag.hotSpot.x: width / 2
                                                    Drag.hotSpot.y: height / 2
                                                    Drag.dragType: Drag.Automatic
                                                    Drag.supportedActions: Qt.CopyAction | Qt.MoveAction
                                                    Drag.keys: ["application/x-pin-item"]
                                                    Drag.mimeData: {
                                                        var mData = {};
                                                        mData["text/plain"] = model.name;
                                                        if (model.desktop && model.desktop.length > 0) {
                                                            mData["text/uri-list"] = ["file://" + model.desktop];
                                                        }
                                                        return mData;
                                                    }

                                                    ColumnLayout {
                                                        anchors.centerIn: parent
                                                        spacing: 6
                                                        Kirigami.Icon {
                                                            source: model.icon
                                                            Layout.preferredWidth: 50
                                                            Layout.preferredHeight: 50
                                                            Layout.alignment: Qt.AlignHCenter
                                                        }
                                                        Text {
                                                            text: model.name
                                                            color: "white"
                                                            font.pixelSize: 11
                                                            font.weight: Font.Medium
                                                            Layout.alignment: Qt.AlignHCenter
                                                            elide: Text.ElideRight
                                                            maximumLineCount: 1
                                                        }
                                                    }

                                                    MouseArea {
                                                        id: dragArea
                                                        anchors.fill: parent
                                                        hoverEnabled: true
                                                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                                                        cursorShape: drag.active ? Qt.ClosedHandCursor : Qt.PointingHandCursor
                                                        drag.target: pinVisual

                                                        drag.onActiveChanged: {
                                                            fullScope.isDraggingAny = drag.active;
                                                            if (drag.active) {
                                                                pinVisual.Drag.start();
                                                            } else {
                                                                pinVisual.Drag.drop();
                                                                pinVisual.x = 0;
                                                                pinVisual.y = 0;
                                                            }
                                                        }

                                                        onClicked: function(mouse) {
                                                            if (mouse.button === Qt.RightButton) {
                                                                fullScope.contextTargetApp = {
                                                                    name: model.name,
                                                                    icon: model.icon,
                                                                    cmd: model.cmd,
                                                                    desktop: model.desktop,
                                                                    isPinned: true
                                                                };
                                                                appContextMenu.popup();
                                                            } else {
                                                                root.launchCommand(model.cmd);
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }

                                    // Recommended Header
                                    RowLayout {
                                        Layout.fillWidth: true
                                        Text {
                                            text: "Recommended"
                                            color: "white"
                                            font.pixelSize: 13
                                            font.weight: Font.DemiBold
                                        }
                                        Item { Layout.fillWidth: true }
                                        Rectangle {
                                            width: 72
                                            height: 24
                                            radius: 6
                                            color: recMoreMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.18) : Qt.rgba(1, 1, 1, 0.08)
                                            border.color: Qt.rgba(1, 1, 1, 0.15)
                                            Text {
                                                anchors.centerIn: parent
                                                text: fullScope.showMorePinned ? "< Less" : "More >"
                                                color: "white"
                                                font.pixelSize: 11
                                            }
                                            MouseArea {
                                                id: recMoreMouse
                                                anchors.fill: parent
                                                hoverEnabled: true
                                                cursorShape: Qt.PointingHandCursor
                                                onClicked: fullScope.showMorePinned = !fullScope.showMorePinned
                                            }
                                        }
                                    }

                                    // Recommended 2-Column Grid (Filled with Real User Files: Screenshots, Text, Downloads, PDFs, Notes)
                                    GridLayout {
                                        Layout.fillWidth: true
                                        columns: 2
                                        columnSpacing: 10
                                        rowSpacing: 4

                                        Repeater {
                                            model: [
                                                { name: "Screenshot-230544.png", desc: "Pictures/Screenshots • Image", icon: "image-png", path: "/home/sir/Pictures/Screenshots/Screenshot-20261127-230544.png", extra: false },
                                                { name: "proxy.txt", desc: "Desktop/ops • Text Document", icon: "text-plain", path: "/home/sir/Desktop/ops/proxy.txt", extra: false },
                                                { name: "Antigravity IDE.tar.gz", desc: "Downloads • Archive", icon: "package-x-generic", path: "/home/sir/Downloads/Antigravity IDE.tar.gz", extra: false },
                                                { name: "antigravity-skills.md", desc: "Desktop/ops • Markdown", icon: "text-markdown", path: "/home/sir/Desktop/ops/antigravity-skills.md", extra: false },
                                                { name: "Emil_Suleymanli_CV.pdf", desc: "Desktop • PDF Document", icon: "application-pdf", path: "/home/sir/Desktop/Emil_Suleymanli_CV_EN.pdf", extra: true },
                                                { name: "DiscordCanarySetup.exe", desc: "Downloads • Executable", icon: "application-x-ms-dos-executable", path: "/home/sir/Downloads/DiscordCanarySetup.exe", extra: true },
                                                { name: "Screenshot-225033.png", desc: "Pictures/Screenshots • Image", icon: "image-png", path: "/home/sir/Pictures/Screenshots/Screenshot-20261127-225033.png", extra: true },
                                                { name: "games.json", desc: "Desktop • JSON Config", icon: "application-json", path: "/home/sir/Desktop/games.json", extra: true }
                                            ]

                                            delegate: Rectangle {
                                                visible: !modelData.extra || fullScope.showMorePinned
                                                Layout.fillWidth: true
                                                Layout.preferredHeight: 46
                                                radius: 7
                                                color: recItemMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.09) : "transparent"
                                                border.color: recItemMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.14) : "transparent"

                                                RowLayout {
                                                    anchors.fill: parent
                                                    anchors.leftMargin: 10
                                                    anchors.rightMargin: 10
                                                    spacing: 10

                                                    Kirigami.Icon {
                                                        source: modelData.icon
                                                        Layout.preferredWidth: 26
                                                        Layout.preferredHeight: 26
                                                    }

                                                    ColumnLayout {
                                                        Layout.fillWidth: true
                                                        spacing: 2
                                                        Text {
                                                            text: modelData.name
                                                            color: "white"
                                                            font.pixelSize: 12
                                                            font.weight: Font.Medium
                                                            elide: Text.ElideRight
                                                            Layout.fillWidth: true
                                                        }
                                                        Text {
                                                            text: modelData.desc
                                                            color: "#a2abbd"
                                                            font.pixelSize: 10
                                                            elide: Text.ElideRight
                                                            Layout.fillWidth: true
                                                        }
                                                    }
                                                }

                                                MouseArea {
                                                    id: recItemMouse
                                                    anchors.fill: parent
                                                    hoverEnabled: true
                                                    cursorShape: Qt.PointingHandCursor
                                                    onClicked: {
                                                        root.launchCommand("xdg-open '" + modelData.path + "'");
                                                        popDialog.requestClose();
                                                    }
                                                }
                                            }
                                        }
                                    }

                                    Item { Layout.fillHeight: true }
                                }
                            }

                            // RIGHT SECTION: Exact Sidebar from screenshot
                            Item {
                                Layout.preferredWidth: 180
                                Layout.fillHeight: true

                                Flickable {
                                    anchors.fill: parent
                                    anchors.leftMargin: 14
                                    anchors.rightMargin: 14
                                    contentHeight: sidebarColumn.implicitHeight
                                    clip: true

                                    ColumnLayout {
                                        id: sidebarColumn
                                        width: parent.width
                                        spacing: 12

                                        // Category 1: PLACES & STORAGE
                                        Text {
                                            text: "PLACES & STORAGE"
                                            color: "#38bdf8"
                                            font.pixelSize: 10
                                            font.weight: Font.Bold
                                            font.letterSpacing: 0.6
                                        }

                                        ColumnLayout {
                                            Layout.fillWidth: true
                                            spacing: 4

                                            Repeater {
                                                model: [
                                                    { name: "Home", desc: "~/ (Personal Folder)", icon: "user-home-symbolic", path: "/home/sir" },
                                                    { name: "Documents", desc: "~/Documents", icon: "folder-documents-symbolic", path: "/home/sir/Documents" },
                                                    { name: "Downloads", desc: "~/Downloads", icon: "folder-download-symbolic", path: "/home/sir/Downloads" },
                                                    { name: "Pictures", desc: "~/Pictures", icon: "folder-pictures-symbolic", path: "/home/sir/Pictures" },
                                                    { name: "Music", desc: "~/Music", icon: "folder-music-symbolic", path: "/home/sir/Music" },
                                                    { name: "Videos", desc: "~/Videos", icon: "folder-videos-symbolic", path: "/home/sir/Videos" }
                                                ]

                                                delegate: Rectangle {
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 36
                                                    radius: 6
                                                    color: sideItemMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.22) : "transparent"
                                                    border.color: sideItemMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.35) : "transparent"

                                                    RowLayout {
                                                        anchors.fill: parent
                                                        anchors.leftMargin: 6
                                                        anchors.rightMargin: 6
                                                        spacing: 10

                                                        Kirigami.Icon {
                                                            source: modelData.icon
                                                            Layout.preferredWidth: 16
                                                            Layout.preferredHeight: 16
                                                        }

                                                        ColumnLayout {
                                                            Layout.fillWidth: true
                                                            spacing: 1
                                                            Text {
                                                                text: modelData.name
                                                                color: "white"
                                                                font.pixelSize: 11
                                                                font.weight: Font.Medium
                                                            }
                                                            Text {
                                                                text: modelData.desc
                                                                color: "#a2abbd"
                                                                font.pixelSize: 9
                                                                elide: Text.ElideRight
                                                                Layout.fillWidth: true
                                                            }
                                                        }
                                                    }

                                                    MouseArea {
                                                        id: sideItemMouse
                                                        anchors.fill: parent
                                                        hoverEnabled: true
                                                        cursorShape: Qt.PointingHandCursor
                                                        onClicked: root.openFolder(modelData.path)
                                                    }
                                                }
                                            }
                                        }

                                        // Category 2: SECURITY & NETWORK
                                        Text {
                                            text: "SECURITY & NETWORK"
                                            color: "#00f2fe"
                                            font.pixelSize: 10
                                            font.weight: Font.Bold
                                            font.letterSpacing: 0.6
                                        }

                                        ColumnLayout {
                                            Layout.fillWidth: true
                                            spacing: 4

                                            Repeater {
                                                model: [
                                                    { name: "Nmap Scanner", desc: "Network Recon", icon: "security-high", cmd: "konsole -e nmap --help" },
                                                    { name: "Wireshark", desc: "Packet Analysis", icon: "network-wired", cmd: "wireshark" },
                                                    { name: "Burp Suite", desc: "Web Security", icon: "security-medium", cmd: "burpsuite" },
                                                    { name: "Metasploit", desc: "Exploit Framework", icon: "utilities-terminal", cmd: "konsole -e msfconsole" }
                                                ]

                                                delegate: Rectangle {
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 36
                                                    radius: 6
                                                    color: secMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.22) : "transparent"
                                                    border.color: secMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.35) : "transparent"

                                                    RowLayout {
                                                        anchors.fill: parent
                                                        anchors.leftMargin: 6
                                                        anchors.rightMargin: 6
                                                        spacing: 10

                                                        Kirigami.Icon {
                                                            source: modelData.icon
                                                            Layout.preferredWidth: 16
                                                            Layout.preferredHeight: 16
                                                        }

                                                        ColumnLayout {
                                                            Layout.fillWidth: true
                                                            spacing: 1
                                                            Text {
                                                                text: modelData.name
                                                                color: "white"
                                                                font.pixelSize: 11
                                                                font.weight: Font.Medium
                                                            }
                                                            Text {
                                                                text: modelData.desc
                                                                color: "#a2abbd"
                                                                font.pixelSize: 9
                                                                elide: Text.ElideRight
                                                                Layout.fillWidth: true
                                                            }
                                                        }
                                                    }

                                                    MouseArea {
                                                        id: secMouse
                                                        anchors.fill: parent
                                                        hoverEnabled: true
                                                        cursorShape: Qt.PointingHandCursor
                                                        onClicked: root.launchCommand(modelData.cmd)
                                                    }
                                                }
                                            }
                                        }

                                        // Category 3: SYSTEM & TOOLS
                                        Text {
                                            text: "SYSTEM & TOOLS"
                                            color: "#38bdf8"
                                            font.pixelSize: 10
                                            font.weight: Font.Bold
                                            font.letterSpacing: 0.6
                                        }

                                        ColumnLayout {
                                            Layout.fillWidth: true
                                            spacing: 4

                                            Repeater {
                                                model: [
                                                    { name: "System Settings", desc: "Hardware & Display", icon: "configure", cmd: "systemsettings" },
                                                    { name: "About System", desc: "OS & Kernel Info", icon: "help-about-symbolic", cmd: "kinfocenter" },
                                                    { name: "Package Manager", desc: "Pacman / AUR", icon: "package-x-generic", cmd: "plasma-discover" }
                                                ]

                                                delegate: Rectangle {
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 36
                                                    radius: 6
                                                    color: sysToolMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.22) : "transparent"
                                                    border.color: sysToolMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.35) : "transparent"

                                                    RowLayout {
                                                        anchors.fill: parent
                                                        anchors.leftMargin: 6
                                                        anchors.rightMargin: 6
                                                        spacing: 10

                                                        Kirigami.Icon {
                                                            source: modelData.icon
                                                            Layout.preferredWidth: 16
                                                            Layout.preferredHeight: 16
                                                        }

                                                        ColumnLayout {
                                                            Layout.fillWidth: true
                                                            spacing: 1
                                                            Text {
                                                                text: modelData.name
                                                                color: "white"
                                                                font.pixelSize: 11
                                                                font.weight: Font.Medium
                                                            }
                                                            Text {
                                                                text: modelData.desc
                                                                color: "#a2abbd"
                                                                font.pixelSize: 9
                                                                elide: Text.ElideRight
                                                                Layout.fillWidth: true
                                                            }
                                                        }
                                                    }

                                                    MouseArea {
                                                        id: sysToolMouse
                                                        anchors.fill: parent
                                                        hoverEnabled: true
                                                        cursorShape: Qt.PointingHandCursor
                                                        onClicked: root.launchCommand(modelData.cmd)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        // -----------------------------------------------------
                        // 3. BOTTOM FOOTER BAR (Profile + Power Button)
                        // -----------------------------------------------------
                        Item {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 60

                            // Rounded bottom background matching outer radius 16 cleanly
                            Rectangle {
                                anchors.fill: parent
                                anchors.leftMargin: 1
                                anchors.rightMargin: 1
                                anchors.bottomMargin: 1
                                radius: 15
                                color: Qt.rgba(0, 0, 0, 0.25)
                            }

                            // Flat upper strip so top corners stay square along the divider
                            Rectangle {
                                anchors.top: parent.top
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.leftMargin: 1
                                anchors.rightMargin: 1
                                height: 35
                                color: Qt.rgba(0, 0, 0, 0.25)
                            }

                            // Top divider line
                            Rectangle {
                                anchors.top: parent.top
                                anchors.left: parent.left
                                anchors.right: parent.right
                                height: 1
                                color: Qt.rgba(1, 1, 1, 0.12)
                            }

                            RowLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 24
                                anchors.rightMargin: 24

                                RowLayout {
                                    spacing: 12

                                    Rectangle {
                                        width: 32
                                        height: 32
                                        radius: 16
                                        color: "#0084ff"

                                        Image {
                                            anchors.fill: parent
                                            visible: kuser.faceIconUrl != ""
                                            source: kuser.faceIconUrl
                                        }

                                        Text {
                                            anchors.centerIn: parent
                                            visible: kuser.faceIconUrl == ""
                                            text: (kuser.loginName ? kuser.loginName.charAt(0).toUpperCase() : "S")
                                            color: "white"
                                            font.bold: true
                                            font.pixelSize: 15
                                        }
                                    }

                                    ColumnLayout {
                                        spacing: 1
                                        Text {
                                            text: kuser.fullName ? kuser.fullName : (kuser.loginName ? kuser.loginName : "sir")
                                            color: "white"
                                            font.pixelSize: 13
                                            font.weight: Font.DemiBold
                                        }
                                        Text {
                                            text: "Arch Linux KDE Plasma 6.8"
                                            color: "#a2abbd"
                                            font.pixelSize: 11
                                        }
                                    }
                                }

                                Item { Layout.fillWidth: true }

                                Rectangle {
                                    width: 36
                                    height: 36
                                    radius: 8
                                    color: powerBtnMouse.containsMouse ? Qt.rgba(1, 0.26, 0.26, 0.25) : Qt.rgba(1, 1, 1, 0.05)
                                    border.color: powerBtnMouse.containsMouse ? Qt.rgba(1, 0.26, 0.26, 0.45) : Qt.rgba(1, 1, 1, 0.1)

                                    Kirigami.Icon {
                                        anchors.centerIn: parent
                                        source: "system-shutdown"
                                        width: 18
                                        height: 18
                                    }

                                    MouseArea {
                                        id: powerBtnMouse
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: {
                                            powerMenu.popup(powerBtnMouse, 0, -powerMenu.implicitHeight);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
