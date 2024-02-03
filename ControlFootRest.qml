import QtQuick 2.13
import QtQuick.Controls 2.1

Item {
    id: root

    property int countValue: 0

    height: childrenRect.height

    Item {
        id: increasetext

        anchors.horizontalCenter: parent.horizontalCenter
        width: childrenRect.width
        height: 10

        Text {
            id: increaseHeightText

            anchors {
                top: parent.top
                topMargin: 10
            }

            text: "Increase"
            color: "White"
        }
    }

    Rectangle {
        id: upButton

        width: childrenRect.width
        height: childrenRect.height

        anchors {
            top: increasetext.bottom
            topMargin: 30
            horizontalCenter: increasetext.horizontalCenter
        }

        color: "lightgrey"

        Image {
            id: upImage

            source: "arrowUp.svg"
        }
    }

    Rectangle {
        id: value

        width: 40
        height: 40

        anchors {
            top: upButton.bottom
            horizontalCenter: upButton.horizontalCenter
        }

        Text {
            id: valueText

            text: countValue
            color: "Black"

            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: downButton

        width: childrenRect.width
        height: childrenRect.height

        anchors {
            top: value.bottom
            horizontalCenter: value.horizontalCenter
        }

        color: "lightgrey"

        Image {
            id: downImage

            source: "arrowDown.svg"
        }
    }

    Item {
        id: decreaseHeight

        width: childrenRect.width
        height: 10

        anchors {
            top: downButton.bottom
            topMargin: 10
            horizontalCenter: downButton.horizontalCenter
        }

        Text {
            id: decreaseHeightText

            text: "decrease"
            color: "White"
        }
    }

    MouseArea {
        anchors.fill: upButton

        onClicked: {
            if (countValue <= 89) {
                countValue++;
            }
        }
    }

    MouseArea {
        anchors.fill: downButton

        onClicked: {
            if (countValue >= 1) {
                countValue--;
            }
        }
    }
}
