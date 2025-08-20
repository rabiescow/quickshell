pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

Item {
    id: root
    implicitWidth: row.width
    implicitHeight: row.height

    required property string prefix
    default property alias content: contentItem.sourceComponent

    Rectangle {
        anchors.fill: row
        anchors.leftMargin: -3
        anchors.rightMargin: anchors.leftMargin
        anchors.topMargin: 1
        anchors.bottomMargin: 1
        border.width: 0
        border.pixelAligned: true

        color: "#11111b"
    }

    RowLayout {
        id: row

        layoutDirection: root.prefix == ">" ? Qt.RightToLeft : Qt.LeftToRight
        spacing: 4

        BarText {
            text: root.prefix
            color: "#1e1e2e"
            font.pointSize: 14
        }

        Loader {
            id: contentItem
        }
    }
}
