import qs.config
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick

Repeater {
    id: tray
    model: SystemTray.items
    delegate: Item {
        width: 24
        height: 24

        Rectangle {
            anchors.centerIn: parent
            width: 16
            height: 16
            IconImage {
                asynchronous: true
                source: {
                    let icon = modelData?.icon || "";
                    if (!icon)
                        return "";
                    if (icon.includes("?path=")) {
                        const [name, path] = icon.split("?path=");
                        const fileName = name.substring(name.lastIndexOf("/") + 1);
                        return `file://$path/$fileName`;
                    }
                    return icon;
                }
                opacity: status === Image.Ready ? 1 : 0

                Behavior on opacity {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutCubic
                    }
                }
                Component.onCompleted: {}
            }
        }
    }
}
