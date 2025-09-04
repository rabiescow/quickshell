import QtQuick
import QtQuick.Layouts

Item {
    id: trayMaster
    implicitHeight: parent.height
    implicitWidth: trayOpen ? 320 : trayButton.width

    property bool trayOpen: true

    function toggleTray() {
        if (trayOpen) {
            trayOpen = false;
        } else {
            trayOpen = true;
        }
        isActive = trayOpen;
    }

    Behavior on implicitWidth {
        PropertyAnimation {
            duration: 500
            easing.type: Easing.OutExpo
        }
    }

    Row {
        spacing: 5
        anchors.fill: parent
        Text {
            id: trayButton
            anchors.verticalCenter: parent.verticalCenter
            text: trayOpen ? "" : ""
            color: "#232332"
            font.pointSize: 15

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: parent.color = "#1e1e2e"
                onExited: parent.color = "#232332"
                onPressed: toggleTray()
            }
        }

        // The actuall tray
        Item {
            id: tray
            visible: trayOpen
            implicitHeight: trayMaster.height
            implicitWidth: trayMaster.width - trayButton.width - parent.spacing
            RowLayout {
                anchors.fill: parent

                // Put items here
            }
        }
    }
}
