import QtQuick 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.4

import "../controls"
import "../delegates"

Rectangle {
    id: root
    color: "#162170"

    ColumnLayout
    {
        anchors.fill: parent
        anchors.margins: 10

        Icon
        {
            color: "cyan"
            size: 80
            icon: "\uf808"

            Layout.alignment: Qt.AlignHCenter
            Layout.leftMargin: 10
        }

        Text {
            text: "<font color='#00de73'>Mental</font> <font color='#ff2000'>State</font> <font color='white'>Health</font>"
            font.pixelSize: 40
            font.bold: true
            textFormat: Text.StyledText
            color: "#2e2e2e"

            Layout.alignment: Qt.AlignHCenter
        }

        Rectangle
        {
            color: Qt.darker(root.color, 1.5)
            radius: 5

            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.topMargin: 20
            Layout.bottomMargin: 20

            Rectangle
            {
                id: menuRibbon
                width: parent.width-10
                height: 50
                radius: 5
                color: "#2e2e2e"

                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: 5

                Text {
                    text: qsTr("Showing All Patients")
                    font.pixelSize: 18
                    color: "white"

                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                }

                CircularTextField
                {
                    width: 250
                    height: 40
                    font.pixelSize: 15
                    placeholderText: qsTr("Enter patient name")

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: addUsrBtn.left
                    anchors.rightMargin: 20
                }

                IconButton
                {
                    id: addUsrBtn
                    icon: "\uf234"
                    text: "New Patient"
                    height: 40

                    onClicked: patientPopup.open()

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                }
            }

            ScrollView
            {
                id: scroll
                clip: true
                spacing: 1

                anchors.top: menuRibbon.bottom
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.rightMargin: 5
                anchors.leftMargin: 5
                anchors.topMargin: 10

                ListView
                {
                    id: listView
                    width: scroll.width-20
                    height: scroll.height
                    model: usersModel
                    spacing: 5
                    delegate: UserDelegate {
                        id: dlg
                        width: listView.width
                        u_name: name
                        u_id: userId
                        u_deviceId: deviceID
                        u_contact: contact
                        t_name: therapistName
                        t_num: therapistNum
                        dt: dateAdded
                        bpm: lastBpm + qsTr(" bpm")
                        edh: lastEdh + qsTr(" µS")
                        isUserStarred: isStarred
                        dateUpdated: Qt.formatDateTime(new Date(), "ddd, hh:mm.ss AP")

                        onClicked: userDetailsPopup.start(u_name, u_id, u_deviceId, u_contact, t_name, t_num, isUserStarred)

                        Timer
                        {
                            id: xTimer
                            interval: Math.floor(Math.random()*10000 ) + 2000
                            running: true
                            repeat: true

                            onTriggered: {
                                bpm = userDetailsPopup.chart.shuffleList()["b"] + qsTr(" bpm")
                                edh = userDetailsPopup.chart.shuffleList()["c"] + qsTr(" µS")
                                dateUpdated = Qt.formatDateTime(new Date(), "ddd, hh:mm.ss AP")
                            }
                        }

                    }
                }
            }
        }
    }
}
