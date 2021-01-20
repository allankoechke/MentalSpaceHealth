import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

import "../controls"

Rectangle {
    id: root
    width: 60+txt.paintedWidth
    border.color: "white"
    border.width: 1
    radius: height/2
    color: "transparent"

    property alias icon: ico.icon
    property alias text: txt.text

    signal clicked()

    Icon
    {
        id: ico
        width: 30; height: 30
        color: "white"
        size: 22
        icon: "\uf142"

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 10
        verticalAlignment: "AlignVCenter"
        horizontalAlignment: "AlignHCenter"
    }

    Text {
        id: txt
        text: qsTr("")
        font.pixelSize: 15
        color: "white"

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: ico.right
        anchors.leftMargin: 10

        Component.onCompleted: root.width = 60+txt.paintedWidth
    }

    MouseArea
    {
        anchors.fill: parent
        onClicked: root.clicked()
    }
}
