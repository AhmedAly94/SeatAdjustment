import "." as Seats
import QtQuick 2.13
import QtQuick.Layouts 1.13
import QtQuick.Controls 1.4
import QtQuick.Controls 2.1

Rectangle {
    id: root

    property int headRestSavedValue: 0
    property int backRestSavedValue: 0
    property int footRestSavedValue: 0
    property int seatHardnessSavedValue: 0

    width: 1000
    height: 800
    color: "black"

    /*!
        Title
    */
    Item {
        id: seatAdjustmentLabel

        width: 100
        height: 100

        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }

        Text {
            anchors.centerIn: parent
            text: "Seat Adjustment"
            color: "White"
            font {
                pointSize: 18
                bold: true
            }
        }
    }

    /*!
        Default Button to rest the positions for TakeOff , Landing or Emergencies
    */
    Item {
        id: resetButton

        Button {
            id: reset

            text: "Default Position"

            onClicked: {
                stack.headRestValue = 0;
                stack.backRestValue = 90;
                stack.footRestValue = 0;
                stack.seatValue = 1;
            }
        }
    }

    /*!
        Save/Saved adjustments Buttons
    */
    Item {
        id: rowButtons

        anchors {
            right: parent.right
            top: seatAdjustmentLabel.bottom
            rightMargin: 30
            topMargin: 10
        }

        width: 600
        height: 100

        Button {
            id: load

            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
            }

            text: "Saved Adjustements"

            onClicked: {
                stack.backRestValue = backRestSavedValue;
                stack.headRestValue = headRestSavedValue;
                stack.footRestValue = footRestSavedValue;
                stack.seatValue = seatHardnessSavedValue;
            }
        }

        Button {
            id: saveAdjustments

            anchors {
                right: load.left
                rightMargin: 20
                verticalCenter: parent.verticalCenter
            }

            text: "Save Adjustments"

            onClicked: {
                backRestSavedValue = stack.backRestValue;
                headRestSavedValue = stack.headRestValue;
                footRestSavedValue = stack.footRestValue;
                seatHardnessSavedValue = stack.seatValue;
            }
        }
    }

    Component {
        id: menu

        Rectangle {
            id: menuIcons

            width: 250
            height: childrenRect.height

            color: "black"

            anchors.centerIn: parent

            ColumnLayout {
                id: icons

                width: 120
                spacing: 60

                RadioButton {
                    id: headSeat

                    text: qsTr("HeadRest")
                    contentItem: Text {
                        id: headRestText

                        text: headSeat.text
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: headSeat.indicator.width + headSeat.spacing
                        color: "grey"
                    }

                    onClicked: {
                        seatAnglesText.color = "grey";
                        headRestText.color = "white";
                        footRestText.color = "grey";
                        seatHardnessText.color = "grey";
                        stack.currentIndex = 1;
                    }
                }

                RadioButton {
                    id: seat

                    text: qsTr("BackRest")
                    contentItem: Text {
                        id: seatAnglesText

                        text: seat.text
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: seat.indicator.width + seat.spacing
                        color: "grey"
                    }

                    onClicked: {
                        seatAnglesText.color = "white";
                        headRestText.color = "grey";
                        footRestText.color = "grey";
                        seatHardnessText.color = "grey";
                        stack.currentIndex = 2;
                    }
                }

                RadioButton {
                    id: footRest

                    text: qsTr("FootRest")
                    contentItem: Text {
                        id: footRestText

                        text: footRest.text
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: footRest.indicator.width + footRest.spacing
                        color: "grey"
                    }
                    onClicked: {
                        footRestText.color = "white";
                        seatAnglesText.color = "grey";
                        headRestText.color = "grey";
                        seatHardnessText.color = "grey";
                        stack.currentIndex = 3;
                    }
                }

                RadioButton {
                    id: seatHardness

                    text: qsTr("SeatHardness Level")
                    contentItem: Text {
                        id: seatHardnessText

                        text: seatHardness.text
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: seatHardness.indicator.width + seatHardness.spacing
                        color: "grey"
                    }
                    onClicked: {
                        seatHardnessText.color = "white";
                        seatAnglesText.color = "grey";
                        headRestText.color = "grey";
                        footRestText.color = "grey";
                        stack.currentIndex = 4;
                    }
                }
            }

            Rectangle {
                id: separator

                color: "white"
                width: 1
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: parent.right
                }
            }
        }
    }

    Loader {
        id: leftMenu

        sourceComponent: menu
        anchors.verticalCenter: parent.verticalCenter
    }

    StackLayout {
        id: stack

        property alias headRestValue: controlHeadRest.value
        property alias backRestValue: control.backRest
        property alias footRestValue: controlFoot.footRest
        property alias seatValue: controlSeatHardness.state

        anchors.fill: parent

        Item {
            id: description

            Text {
                text: "Please select your desired seat part \n to adjust your own comfortable position"
                color: "white"
                anchors.centerIn: parent
            }
        }

        Seats.ControlHeadRest {
            id: controlHeadRest
        }

        Item {
            id: control

            property alias backRest: controlBackRest.value

            Seats.ControlBackRest {
                id: controlBackRest

                anchors.centerIn: parent
            }
        }

        Item {
            id: controlFoot

            property alias footRest: controlFootRest.countValue

            Seats.ControlFootRest {
                id: controlFootRest

                anchors.centerIn: parent
            }
        }

        Seats.ControlSeatHardness {
            id: controlSeatHardness
        }
    }
}
