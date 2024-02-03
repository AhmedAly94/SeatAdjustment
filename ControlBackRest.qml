import QtQml 2.15
import QtQuick 2.14
import QtQuick.Controls 2.14
import QtGraphicalEffects 1.14

Slider {
    id: root

    property real nullPosition: from / (from - to)
    property real handleDiameter: 21
    property real __grooveHeight: 4
    property real __grooveAreaHeight: 24
    property real __textAreaTopMargin: 7
    property bool showScale: true
    property bool showText: true
    property bool synchronised: true
    property var lowerAngle: 90
    property var higherAngle: 180

    width: 325
    from: lowerAngle
    to: higherAngle
    stepSize: 1
    enabled: true

    background: Rectangle {
        y: (root.height - height) / 2
        width: root.width
        height: root.__grooveHeight
        radius: height / 2
        color: "Grey"

        Rectangle {
            id: groove

            width: parent.width
            height: parent.height
            radius: height / 2
            visible: false
            color: root.synchronised ? "Gold" : "Grey"
        }

        Item {
            id: mask

            width: parent.width
            height: parent.height
            visible: false

            Rectangle {
                id: maskRectangle

                readonly property real signedWidth: parent.width * (root.visualPosition - root.nullPosition)

                x: parent.width * Math.min(root.nullPosition, root.visualPosition)
                width: Math.abs(signedWidth)
                height: parent.height
                radius: height / 2
            }
        }

        OpacityMask {
            anchors.fill: groove
            source: groove
            maskSource: mask
            visible: root.enabled
        }
    }

    handle: Rectangle {
        id: handle

        x: root.visualPosition * (root.width - width)
        y: background.y - (height - background.height) / 2
        implicitWidth: root.enabled ? handleDiameter : 4
        implicitHeight: root.handleDiameter
        radius: width / 2
        color: root.enabled ? "White" : "Gold"

        layer {
            enabled: true
            effect: DropShadow {
                horizontalOffset: 1
                verticalOffset: 1
                color: "Black"
                opacity: 0.3
            }
        }
    }

    Repeater {
        id: tickMarks

        property real tickCount: root.stepSize ? Math.abs(root.to - root.from) / root.stepSize : 0
        property real maxSpacing: root.width - handle.width
        property real spacing: maxSpacing / tickCount

        model: root.showScale ? tickCount + (root.showText ? 0 : 1) : 0
        delegate: Rectangle {
            id: tickLine

            width: 1
            height: 6
            x: handle.width / 2 + Math.min((index * tickMarks.spacing), tickMarks.maxSpacing) - width / 2
            y: background.y + (background.height + __grooveAreaHeight) / 2
            visible: root.showText ? index > 0 : true
            color: root.enabled ? "Grey" : "Grey"
        }
    }

    Text {
        id: lowAngleText

        width: root.width
        color: root.enabled ? "White" : "Grey"
        text: root.lowerAngle + "°"
        visible: root.showText
        anchors {
            top: handle.bottom
            topMargin: 20
        }
    }

    Text {
        id: highAngleText

        width: root.width
        y: root.__grooveAreaHeight + root.__textAreaTopMargin
        horizontalAlignment: Text.AlignRight
        color: root.enabled ? "White" : "Grey"
        text: root.higherAngle + "°"
        visible: root.showText
        anchors {
            top: handle.bottom
            topMargin: 20
        }
    }

    Item {
        id: sliderValues

        anchors.fill: parent

        anchors {
            top: parent.bottom
            topMargin: 120
        }

        Text {
            anchors.centerIn: parent
            color: "white"

            text: {
                if (value == 90) {
                    "Angle is 90 ° in upright position";
                } else if (value == 180) {
                    "Angle is 180 ° in sleep mode position";
                } else {
                    "Angle is  " + value + "°";
                }
            }
        }
    }
}
