import QtQuick 2.12
import QtQuick.Layouts 1.3

import "../controls"

Rectangle {
    id: root
    color: "#162170"

    Timer
    {
        id: loginTimer
        interval: 5000
        running: true
        repeat: false

        onTriggered: stackCurrentIndex = 1

    }

    RotationAnimation
    {
        id: spinRotationAnimation
        target: spin
        from: 0; to: 360
        running: true
        duration: 1000
        loops: RotationAnimation.Infinite
    }

    Icon
    {
        id: spin
        color: "white"
        size: 60
        icon: "\uf110"

        anchors.centerIn: parent
    }

    Text {
        id: load
        color: "white"
        font.pixelSize: 18
        text: qsTr("Loading ...")

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: spin.bottom
        anchors.topMargin: 20
    }
}
