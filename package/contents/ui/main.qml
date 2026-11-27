import "search_engine.js" as SearchEngine
import "search_db.js" as SearchDB
import "tools_db.js" as ToolsDB
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

    width: 850
    height: 720

    KCoreAddons.KUser {
        id: kuser
    }

    Kicker.RunnerModel {
        id: runnerModel
        appletInterface: root
    }
    Connections {
        target: runnerModel
        function onCountChanged() {
            if (fullScope.isSearching) {
                fullScope.performInstantSearch(searchInput.text);
            }
        }
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

    property var sidebarPlaces: (typeof ToolsDB !== "undefined" && ToolsDB.toolsDb && ToolsDB.toolsDb.places) ? ToolsDB.toolsDb.places : [
        { name: "Home", desc: "~/ (Personal Folder)", icon: "user-home-symbolic", path: "/home/sir" },
        { name: "Documents", desc: "~/Documents", icon: "folder-documents-symbolic", path: "/home/sir/Documents" },
        { name: "Downloads", desc: "~/Downloads", icon: "folder-download-symbolic", path: "/home/sir/Downloads" },
        { name: "Pictures", desc: "~/Pictures", icon: "folder-pictures-symbolic", path: "/home/sir/Pictures" },
        { name: "Music", desc: "~/Music", icon: "folder-music-symbolic", path: "/home/sir/Music" },
        { name: "Videos", desc: "~/Videos", icon: "folder-videos-symbolic", path: "/home/sir/Videos" }
    ]
    property var sidebarCategories: (typeof ToolsDB !== "undefined" && ToolsDB.toolsDb && ToolsDB.toolsDb.categories) ? ToolsDB.toolsDb.categories : []
    property var activityColumns: (typeof ToolsDB !== "undefined" && ToolsDB.toolsDb && ToolsDB.toolsDb.activity_columns) ? ToolsDB.toolsDb.activity_columns : []

    Plasma5Support.DataSource {
        id: toolsDataSource
        engine: "executable"
        connectedSources: []
        onNewData: function(sourceName, data) {
            disconnectSource(sourceName);
            var stdout = data["stdout"];
            if (stdout && stdout.length > 0) {
                try {
                    var parsed = JSON.parse(stdout);
                    if (parsed.places && parsed.places.length > 0) {
                        root.sidebarPlaces = parsed.places;
                    }
                    if (parsed.categories && parsed.categories.length > 0) {
                        root.sidebarCategories = parsed.categories;
                    }
                    if (parsed.activity_columns && parsed.activity_columns.length > 0) {
                        root.activityColumns = parsed.activity_columns;
                    }
                } catch(e) {
                    console.log("Error parsing dynamic tools JSON:", e);
                }
            }
        }
        function exec(cmd) {
            connectSource(cmd);
        }
    }

    function refreshTools() {
        var scriptUrl = Qt.resolvedUrl("tools_scanner.py").toString();
        var scriptPath = scriptUrl.replace(/^file:\/\//, "");
        toolsDataSource.exec("python3 '" + scriptPath + "'");
    }

    Timer {
        id: toolRefreshTimer
        interval: 15000
        repeat: true
        running: (dialogWindow && dialogWindow.visible)
        onTriggered: root.refreshTools()
    }

    property QtObject dialogWindow: null

    onScreenGeometryChanged: {
        if (dialogWindow && dialogWindow.visible) {
            dialogWindow.updatePosition();
        }
    }

    Component.onCompleted: {
        dialogWindow = menuDialogComponent.createObject(root);
        plasmoid.activated.connect(function() {
            if (dialogWindow) dialogWindow.toggleMenu();
        });
        root.refreshTools();
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

            width: 850
            height: 720

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
                updatePosition();
                visible = true;
                requestActivate();
                fullScope.forceActiveFocus();
                focusTimer.restart();
                root.refreshTools();
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

            function updatePosition() {
                var screen = root.screenGeometry;
                var appletGlobal = root.mapToGlobal(0, 0);

                // Fallback geometry if screen is not yet initialized right after reboot
                var sWidth = (screen && screen.width > 0) ? screen.width : 1920;
                var sHeight = (screen && screen.height > 0) ? screen.height : 1080;
                var sX = (screen && typeof screen.x !== "undefined") ? screen.x : 0;
                var sY = (screen && typeof screen.y !== "undefined") ? screen.y : 0;

                // Position X: Centered with 10px shift to the right matching taskbar
                var targetX = sX + Math.round((sWidth - width) / 2) + 10;

                // Position Y: Exactly above the bottom panel with 5px margin
                var appletY = (appletGlobal && typeof appletGlobal.y !== "undefined" && appletGlobal.y > 0) ? appletGlobal.y : (sY + sHeight - 48);
                var targetY = appletY - height - 5;
                if (targetY < sY + 12) targetY = sY + 12;

                x = targetX;
                y = targetY;
            }

            onVisibleChanged: {
                if (visible) {
                    isClosing = false;
                    updatePosition();

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
                property string searchPredictionSuffix: ""
                property var topPredictedItem: null

                ListModel { id: searchFilesModel }
                ListModel { id: searchToolsModel }
                property string activeSearchFilter: "All"
                property var selectedSearchItem: null

                function recordAndLaunch(item) {
                    if (!item) return;
                    SearchEngine.recordSearchSelection(item.name, item.type, item.cmd, item.icon, item.desc);
                    if (item.cmd && item.cmd.indexOf("krunner_trigger:") === 0) {
                        var rIdx = parseInt(item.cmd.split(":")[1]);
                        runnerModel.trigger(rIdx, "", null);
                    } else {
                        root.launchCommand(item.cmd);
                    }
                    popDialog.requestClose();
                }

                function performInstantSearch(query) {
                    var q = query.trim().toLowerCase();
                    searchAppsModel.clear();
                    searchFilesModel.clear();
                    searchToolsModel.clear();
                    selectedSearchItem = null;
                    topPredictedItem = null;
                    searchPredictionSuffix = "";

                    if (q.length === 0) return;

                    var allCandidates = [];

                    // 1. Gather all Apps
                    var apps = SearchDB.searchDb.apps || [];
                    var addedAppNames = {};
                    for (var i = 0; i < apps.length; i++) {
                        var a = apps[i];
                        if (a.name.toLowerCase().indexOf(q) !== -1 || a.desc.toLowerCase().indexOf(q) !== -1 || a.category.toLowerCase().indexOf(q) !== -1) {
                            var appWithScore = Object.assign({}, a, { score: SearchEngine.getItemScore(a.name, q) });
                            allCandidates.push(appWithScore);
                            addedAppNames[a.name.toLowerCase()] = true;
                        }
                    }

                    // Dynamic live system RunnerModel integration
                    if (runnerModel && runnerModel.count > 0) {
                        for (var r = 0; r < runnerModel.count; r++) {
                            var rName = runnerModel.data(runnerModel.index(r, 0), Qt.DisplayRole) || "";
                            var rIcon = runnerModel.data(runnerModel.index(r, 0), Qt.DecorationRole) || "application-x-executable";
                            if (typeof rIcon === "object" && rIcon.name) rIcon = rIcon.name;
                            if (rName.length > 0 && !addedAppNames[rName.toLowerCase()]) {
                                var dynamicApp = {
                                    "name": rName,
                                    "icon": rIcon ? rIcon.toString() : "application-x-executable",
                                    "cmd": "krunner_trigger:" + r,
                                    "desc": "System Application",
                                    "category": "System",
                                    "type": "app",
                                    "score": SearchEngine.getItemScore(rName, q)
                                };
                                allCandidates.push(dynamicApp);
                                addedAppNames[rName.toLowerCase()] = true;
                            }
                        }
                    }

                    // Sort apps by frequency score descending
                    allCandidates.sort(function(a, b) { return b.score - a.score; });
                    for (var m = 0; m < allCandidates.length; m++) {
                        searchAppsModel.append(allCandidates[m]);
                    }

                    // 2. Gather Files
                    var files = SearchDB.searchDb.files || [];
                    var matchedFiles = [];
                    for (var j = 0; j < files.length; j++) {
                        var fl = files[j];
                        if (fl.name.toLowerCase().indexOf(q) !== -1 || fl.desc.toLowerCase().indexOf(q) !== -1 || fl.location.toLowerCase().indexOf(q) !== -1) {
                            var fWithScore = Object.assign({}, fl, { score: SearchEngine.getItemScore(fl.name, q) });
                            matchedFiles.push(fWithScore);
                            allCandidates.push(fWithScore);
                        }
                    }
                    matchedFiles.sort(function(a, b) { return b.score - a.score; });
                    for (var n = 0; n < matchedFiles.length; n++) {
                        searchFilesModel.append(matchedFiles[n]);
                    }

                    // 3. Gather Tools
                    var tools = SearchDB.searchDb.tools || [];
                    var matchedTools = [];
                    for (var k = 0; k < tools.length; k++) {
                        var t = tools[k];
                        if (t.name.toLowerCase().indexOf(q) !== -1 || t.desc.toLowerCase().indexOf(q) !== -1 || t.category.toLowerCase().indexOf(q) !== -1) {
                            var tWithScore = Object.assign({}, t, { score: SearchEngine.getItemScore(t.name, q) });
                            matchedTools.push(tWithScore);
                            allCandidates.push(tWithScore);
                        }
                    }
                    matchedTools.sort(function(a, b) { return b.score - a.score; });
                    for (var p = 0; p < matchedTools.length; p++) {
                        searchToolsModel.append(matchedTools[p]);
                    }

                    // 4. Calculate Predictive Autocomplete (knows what user will type next)
                    var topPred = SearchEngine.getTopPrediction(q, allCandidates);
                    if (topPred) {
                        topPredictedItem = topPred;
                        selectedSearchItem = topPred;
                        var rawName = topPred.name;
                        if (rawName.toLowerCase().indexOf(q) === 0) {
                            searchPredictionSuffix = rawName.substring(q.length);
                        }
                    } else if (searchAppsModel.count > 0) {
                        selectedSearchItem = searchAppsModel.get(0);
                    } else if (searchFilesModel.count > 0) {
                        selectedSearchItem = searchFilesModel.get(0);
                    } else if (searchToolsModel.count > 0) {
                        selectedSearchItem = searchToolsModel.get(0);
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

                                    Item {
                                        Layout.fillWidth: true
                                        Layout.fillHeight: true

                                        // Ghost Autocompletion Text (Predicts what user intends to type based on history)
                                        Text {
                                            anchors.left: parent.left
                                            anchors.verticalCenter: parent.verticalCenter
                                            visible: searchInput.text.length > 0 && fullScope.searchPredictionSuffix.length > 0
                                            text: searchInput.text + fullScope.searchPredictionSuffix
                                            color: Qt.rgba(1, 1, 1, 0.35)
                                            font.pixelSize: 14
                                            font.family: "Segoe UI"
                                        }

                                        QQC2.TextField {
                                            id: searchInput
                                            anchors.fill: parent
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
                                            Keys.onTabPressed: {
                                                if (fullScope.searchPredictionSuffix.length > 0) {
                                                    text = text + fullScope.searchPredictionSuffix;
                                                    cursorPosition = text.length;
                                                }
                                            }
                                            Keys.onReturnPressed: {
                                                if (fullScope.topPredictedItem) {
                                                    fullScope.recordAndLaunch(fullScope.topPredictedItem);
                                                } else if (fullScope.selectedSearchItem) {
                                                    fullScope.recordAndLaunch(fullScope.selectedSearchItem);
                                                } else if (runnerModel.count > 0) {
                                                    runnerModel.trigger(0, "", null);
                                                    popDialog.requestClose();
                                                }
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
                                                                if (model.cmd && model.cmd.indexOf("krunner_trigger:") === 0) {
                                                                    var rIdx = parseInt(model.cmd.split(":")[1]);
                                                                    runnerModel.trigger(rIdx, "", null);
                                                                } else {
                                                                    fullScope.recordAndLaunch(model);
                                                                }
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
                                                                if (model.cmd && model.cmd.indexOf("krunner_trigger:") === 0) {
                                                                    var rIdx = parseInt(model.cmd.split(":")[1]);
                                                                    runnerModel.trigger(rIdx, "", null);
                                                                } else {
                                                                    fullScope.recordAndLaunch(model);
                                                                }
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
                                                                if (model.cmd && model.cmd.indexOf("krunner_trigger:") === 0) {
                                                                    var rIdx = parseInt(model.cmd.split(":")[1]);
                                                                    runnerModel.trigger(rIdx, "", null);
                                                                } else {
                                                                    fullScope.recordAndLaunch(model);
                                                                }
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
                                                        fullScope.recordAndLaunch(model);
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
                                    anchors.bottomMargin: 5
                                    visible: !fullScope.isSearching && !fullScope.showAllApps
                                    spacing: 8

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
                                        rowSpacing: 6
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
                                                visible: true
                                                Layout.preferredWidth: 94
                                                Layout.preferredHeight: 70

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
                                                    width: 94
                                                    height: 70
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
                                                        spacing: 4
                                                        Kirigami.Icon {
                                                            source: model.icon
                                                            Layout.preferredWidth: 38
                                                            Layout.preferredHeight: 38
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
                                                                fullScope.recordAndLaunch(model);
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }

                                    Item { Layout.fillHeight: true }

                                    // Recommended Section Header
                                    RowLayout {
                                        Layout.fillWidth: true
                                        Layout.bottomMargin: 4
                                        Text {
                                            text: "Recommended"
                                            color: "white"
                                            font.pixelSize: 13
                                            font.weight: Font.DemiBold
                                        }
                                        Item { Layout.fillWidth: true }
                                    }

                                    // 4-Column Activity Grid: Clean boxes without category names
                                    RowLayout {
                                        Layout.fillWidth: true
                                        spacing: 8

                                        Repeater {
                                            model: root.activityColumns

                                            delegate: ColumnLayout {
                                                Layout.fillWidth: true
                                                Layout.preferredWidth: 1
                                                spacing: 4

                                                Repeater {
                                                    model: modelData.items

                                                    delegate: Rectangle {
                                                        Layout.fillWidth: true
                                                        Layout.preferredHeight: 35
                                                        radius: 6
                                                        color: colItemMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.14) : Qt.rgba(1, 1, 1, 0.04)
                                                        border.color: colItemMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.22) : "transparent"

                                                        RowLayout {
                                                            anchors.fill: parent
                                                            anchors.leftMargin: 6
                                                            anchors.rightMargin: 6
                                                            spacing: 7

                                                            Kirigami.Icon {
                                                                source: modelData.icon || "document-open"
                                                                Layout.preferredWidth: 16
                                                                Layout.preferredHeight: 16
                                                            }

                                                            ColumnLayout {
                                                                Layout.fillWidth: true
                                                                spacing: 1

                                                                Text {
                                                                    text: modelData.name
                                                                    color: "white"
                                                                    font.pixelSize: 10
                                                                    font.weight: Font.Medium
                                                                    elide: Text.ElideRight
                                                                    Layout.fillWidth: true
                                                                }

                                                                Text {
                                                                    text: modelData.desc
                                                                    color: "#a2abbd"
                                                                    font.pixelSize: 8
                                                                    elide: Text.ElideRight
                                                                    Layout.fillWidth: true
                                                                }
                                                            }
                                                        }

                                                        MouseArea {
                                                            id: colItemMouse
                                                            anchors.fill: parent
                                                            hoverEnabled: true
                                                            cursorShape: Qt.PointingHandCursor
                                                            onClicked: {
                                                                if (modelData.cmd) {
                                                                    root.launchCommand(modelData.cmd);
                                                                } else if (modelData.path) {
                                                                    root.launchCommand("xdg-open '" + modelData.path + "'");
                                                                }
                                                                popDialog.requestClose();
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                            // RIGHT SECTION: Exact Sidebar from screenshot
                            Item {
                                Layout.preferredWidth: 195
                                Layout.fillHeight: true

                                Flickable {
                                    id: sidebarFlickable
                                    anchors.fill: parent
                                    anchors.leftMargin: 12
                                    anchors.rightMargin: 8
                                    contentHeight: sidebarColumn.implicitHeight
                                    clip: true
                                    boundsBehavior: Flickable.StopAtBounds

                                    QQC2.ScrollBar.vertical: QQC2.ScrollBar {
                                        policy: QQC2.ScrollBar.AsNeeded
                                        width: 4
                                    }

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
                                                model: root.sidebarPlaces

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

                                        // Dynamic Categories: SECURITY & NETWORK, SYSTEM & TOOLS, DEVELOPMENT & UTILITIES
                                        Repeater {
                                            model: root.sidebarCategories

                                            delegate: ColumnLayout {
                                                Layout.fillWidth: true
                                                spacing: 4

                                                Text {
                                                    text: modelData.title
                                                    color: modelData.color || "#38bdf8"
                                                    font.pixelSize: 10
                                                    font.weight: Font.Bold
                                                    font.letterSpacing: 0.6
                                                }

                                                ColumnLayout {
                                                    Layout.fillWidth: true
                                                    spacing: 4

                                                    Repeater {
                                                        model: modelData.items

                                                        delegate: Rectangle {
                                                            Layout.fillWidth: true
                                                            Layout.preferredHeight: 36
                                                            radius: 6
                                                            color: catItemMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.22) : "transparent"
                                                            border.color: catItemMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.35) : "transparent"

                                                            RowLayout {
                                                                anchors.fill: parent
                                                                anchors.leftMargin: 6
                                                                anchors.rightMargin: 6
                                                                spacing: 10

                                                                Kirigami.Icon {
                                                                    source: modelData.icon || "application-x-executable"
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
                                                                        elide: Text.ElideRight
                                                                        Layout.fillWidth: true
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
                                                                id: catItemMouse
                                                                anchors.fill: parent
                                                                hoverEnabled: true
                                                                cursorShape: Qt.PointingHandCursor
                                                                onClicked: {
                                                                    if (modelData.cmd) {
                                                                        root.launchCommand(modelData.cmd);
                                                                    } else if (modelData.path) {
                                                                        root.openFolder(modelData.path);
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
