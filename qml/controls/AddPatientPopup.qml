import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

import "../controls"

Popup {
    id: root
    height: 450
    width: 600
    modal: true

    closePolicy: "NoAutoClose"
    x: (mainApp.width-width)/2
    y: (mainApp.height-height)/2

    property alias userNames: pName.inputText
    property alias patientId: pId.inputText
    property alias deviceId: dId.inputText
    property alias contactInfo: cInfo.inputText
    property alias therapistName: thName.inputText
    property alias therapistNo: thNo.inputText

    onClosed: {
        userNames=""
        patientId=""
        deviceId=""
        contactInfo=""
        therapistName=""
        therapistNo=""
    }


    background: Rectangle{
        color: "#162170"
    }

    contentItem: ColumnLayout
    {
        anchors.fill: parent
        spacing: 1

        Item{
            Layout.fillWidth: true
            Layout.preferredHeight: 60

            Icon{
                icon: "\uf05a"
                color: "white"
                size: 20

                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 20
            }

            Text {
                text: qsTr("New Patient")
                color: "white"
                font.pixelSize:18
                font.bold: true
                textFormat: Text.StyledText

                anchors.centerIn: parent
            }

            Item
            {
                width: 35; height: 35
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10

                Icon{
                    icon: "\uf057"
                    color: "#ff0000"
                    size: 20

                    anchors.centerIn: parent
                }

                MouseArea
                {
                    anchors.fill: parent
                    onClicked: root.close()
                }
            }

        }

        Rectangle
        {
            color: "grey"

            Layout.fillWidth: true
            Layout.preferredHeight: 1
        }

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 280

            ColumnLayout
            {
                anchors.fill: parent
                anchors.margins: 10
                anchors.leftMargin: 20
                spacing: 5

                TagAndInput {
                    id: pName
                    label: qsTr("Patient Name: ")
                    inputHint: qsTr("Patient Name")
                    Layout.fillWidth: true
                    readOnly: false
                    color: "white"
                }

                TagAndInput {
                    id: pId
                    label: qsTr("Patient ID: ")
                    inputHint: qsTr("Patient ID")
                    Layout.fillWidth: true
                    readOnly: false
                    color: "white"
                }

                TagAndInput {
                    id: dId
                    label: qsTr("Device ID: ")
                    inputHint: qsTr("Device ID")
                    Layout.fillWidth: true
                    readOnly: false
                    color: "white"
                }

                TagAndInput {
                    id: cInfo
                    label: qsTr("Contact Info: ")
                    inputHint: qsTr("Contact Info")
                    Layout.fillWidth: true
                    readOnly: false
                    color: "white"
                }

                TagAndInput {
                    id: thName
                    label: qsTr("Therapist Name: ")
                    inputHint: qsTr("Therapist Name")
                    Layout.fillWidth: true
                    readOnly: false
                    color: "white"
                }

                TagAndInput {
                    id: thNo
                    label: qsTr("Therapist Number: ")
                    inputHint: qsTr("Therapist Number")
                    Layout.fillWidth: true
                    readOnly: false
                    color: "white"
                }
            }
        }

        IconButton
        {
            id: addUsrBtn
            icon: "\uf4fc"
            text: "Save Patient"
            height: 40

            // onClicked: patientPopup.open()
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: 20

            onClicked: {
                if( userNames.length < 4 )
                {
                    console.log("Patient Name is short!")
                }

                else if( patientId.length < 4 )
                {
                    console.log("Patient ID is short!")
                }

                else if( deviceId.length < 4 )
                {
                    console.log("Device ID is short!")
                }

                else if( contactInfo.length < 4 )
                {
                    console.log("Contact Info is short!")
                }

                else if( therapistName.length < 4 )
                {
                    console.log("Therapist Name is short!")
                }

                else if( therapistNo.length < 4 )
                {
                    console.log("Therapist No is short!")
                }

                else
                {
                    if( addPatient(userNames,patientId,deviceId,contactInfo,therapistName,therapistNo))
                    {
                        root.close();
                    } else {
                        console.log("Failed to add to db")
                    }
                }
            }
        }

    }
}
