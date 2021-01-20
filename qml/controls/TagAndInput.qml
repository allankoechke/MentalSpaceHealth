import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.4

Item {
    id: root
    height: 35

    property alias inputText: input.text
    property alias inputHint: input.placeholderText
    property alias label: label_.text
    property alias readOnly: input.readOnly
    property alias color: label_.color
    property alias textInput: input

    RowLayout
    {
        anchors.fill: parent
        spacing: 5

        Text {
            id: label_
            text: qsTr("Patient Name: ")
            color: "#2e2e2e"
            font.pixelSize: 12
            textFormat: Text.StyledText

            Layout.preferredWidth: 150
            Layout.fillHeight: true
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
        }

        TextField
        {
            id: input
            color: "#0a0a2c"
            placeholderText: "Enter Username"
            font.pixelSize: 12
            readOnly: true
            text: ""

            Layout.fillWidth: true
            Layout.fillHeight: true
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
        }
    }
}
