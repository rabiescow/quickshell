pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray
import qs.services
import qs.config

PanelWindow {
    id: root
    anchors {
        top: true
        left: true
        right: true
    }

    Rectangle {}

    implicitHeight: UIConfig.barHeight
    color: "#3011111b"

    Timer {
        interval: SystemConfig.pollInterval
        running: true
        repeat: true
        onTriggered: {
            Cpu.update();
            Mem.update();
            Gpu.update();
            Disk.update();
        }
    }

    RowLayout {
        width: 3440
        RowLayout {
            Layout.alignment: Qt.AlignLeft
            Rectangle {
                Layout.preferredWidth: 10
            }

            Rectangle {
                Layout.preferredWidth: 200
                Layout.preferredHeight: 32
                color: "#1e1e2e"
                transform: Matrix4x4 {
                    matrix: Qt.matrix4x4(1, -0.2, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
                }
                BarText {
                    anchors.centerIn: parent
                    text: {
                        const cpu = Math.round(Cpu.usage * 100);
                        const mem = Math.round(Mem.ramUsage * 100);
                        ` \udb80\udf5b  CPU: ${cpu}%  MEM: ${mem}% `;
                    }
                }
            }

            Rectangle {
                Layout.preferredWidth: 170
                Layout.preferredHeight: 32
                color: "#1e1e2e"
                transform: Matrix4x4 {
                    matrix: Qt.matrix4x4(1, -0.2, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
                }
                BarText {
                    anchors.centerIn: parent
                    text: {
                        text: ` \udb82\ude07  L\ue0b3${Gpu.usage}\ue0b1 M\ue0b3${Gpu.vramUsage}\ue0b1`;
                    }
                }
            }

            Rectangle {
                Layout.preferredWidth: 240
                Layout.preferredHeight: 32
                color: "#1e1e2e"
                transform: Matrix4x4 {
                    matrix: Qt.matrix4x4(1, -0.2, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
                }
                BarText {
                    anchors.centerIn: parent
                    text: {
                        const u = Network.uploadBandwidth.toFixed(2);
                        const d = Network.downloadBandwidth.toFixed(2);
                        ` \uef09   U\ue0b3${u} mb\ue0b1  D\ue0b3${d} mb\ue0b1 `;
                    }
                }
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignRight

            Rectangle {
                Layout.preferredWidth: 160
                Layout.preferredHeight: 32
                color: "#1e1e2e"
                transform: Matrix4x4 {
                    matrix: Qt.matrix4x4(1, -0.2, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
                }
                BarText {
                    anchors.centerIn: parent
                    text: {
                        ` \ued03 ${Audio.volumeIn}%  \uf028  ${Audio.volumeOut}% `;
                    }
                }
            }

            Rectangle {
                Layout.preferredWidth: Hyprland.kbLayout.length * 10 + 50
                Layout.preferredHeight: 32
                color: "#1e1e2e"
                transform: Matrix4x4 {
                    matrix: Qt.matrix4x4(1, -0.2, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
                }
                BarText {
                    anchors.centerIn: parent
                    text: {
                        ` \udb80\udf0c ${Hyprland.kbLayout}`;
                    }
                }
            }

            Rectangle {
                // Layout.preferredWidth: (Hyprland.workspaceNum.length * 10) + 50
                Layout.preferredWidth: 120
                Layout.preferredHeight: 32
                color: "#1e1e2e"
                transform: Matrix4x4 {
                    matrix: Qt.matrix4x4(1, -0.2, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
                }
                BarText {
                    anchors.centerIn: parent
                    text: {
                        ` \uf2d2  ${Hyprland.workspaceNum} `;
                    }
                }
            }

            Item {
                id: trayMaster
                implicitHeight: parent.height
                property bool trayOpen: true

                implicitWidth: trayOpen ? 320 : trayButton.width
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
                            onEntered: parent.color = "#232332"
                            onExited: parent.color = "#1e1e2e"
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
                            Repeater {
                                model: SystemTray.items
                                Tray {
                                    barHeight: 32
                                }
                            }
                        }
                    }
                }
            }

            Rectangle {
                Layout.preferredWidth: 220
                Layout.preferredHeight: 32
                color: "#1e1e2e"
                transform: Matrix4x4 {
                    matrix: Qt.matrix4x4(1, -0.2, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
                }
                BarText {
                    anchors.centerIn: parent
                    text: {
                        Time.time;
                    }
                }
            }
            Rectangle {
                Layout.preferredWidth: 10
            }
        }
    }
}
