import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

import "../controls"

Rectangle {
    id: root

    height: 60
    radius: 5
    color: Qt.lighter("#162170", 1.9)

    signal clicked()

    property bool isUserStarred: false
    property alias u_name: userName.text
    property alias bpm: bpm_.text
    property alias edh: edh_.text
    property string u_id: ""
    property string u_deviceId: ""
    property string u_contact: ""
    property string t_name: ""
    property string t_num: ""
    property string dt

    RowLayout
    {
        anchors.fill: parent
        spacing: 10

        Icon
        {
            color: Qt.darker("white", 1.3)
            size: 45
            icon: "\uf007"

            Layout.alignment: Qt.AlignVCenter
            Layout.leftMargin: 10
        }

        Text {
            id: userName
            text: qsTr("John Doe Marsh")
            font.pixelSize: 17
            color: "white"

            Layout.fillWidth: true
            Layout.fillHeight: true
            horizontalAlignment: Text.ALignLeft
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: edh_
            text: c_ + qsTr(" µS")
            font.pixelSize: 17
            color: Qt.darker("white", 1.3)

            Layout.preferredWidth: 150
            Layout.fillHeight: true
            horizontalAlignment: Text.ALignLeft
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: bpm_
            text: b_ + "bpm"
            font.pixelSize: 17
            color: Qt.darker("white", 1.3)

            Layout.preferredWidth: 150
            Layout.fillHeight: true
            horizontalAlignment: Text.ALignLeft
            verticalAlignment: Text.AlignVCenter
        }

        Rectangle
        {
            visible: false
            height: 44; width: 44; radius: 22
            border.color: "red"
            border.width: 1
            color: "transparent"

            Text {
                text: qsTr("2")
                font.pixelSize: 17
                font.bold: true
                color: "red"

                anchors.centerIn: parent
            }
        }


        Item {
            Layout.fillHeight: true
            Layout.preferredWidth: 30

            Icon
            {
                visible: isUserStarred
                color: "white"
                size: 20
                icon: "\uf005"

                anchors.centerIn: parent
            }
        }

        Item {
            Layout.fillHeight: true
            Layout.preferredWidth: 15
            Layout.rightMargin: 10

            Icon
            {
                color: "white"
                size: 30
                icon: "\uf142"

                anchors.centerIn: parent
            }
        }
    }

    MouseArea
    {
        anchors.fill: parent
        onClicked: root.clicked()
    }
}
