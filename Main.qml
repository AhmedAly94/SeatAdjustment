import "." as Seats
import QtQuick 2.13
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.13

/*!
    \qmltype Main
    \brief UI provides these features:
    . The seat has a headrest that can be retracted and extended.
    . The seat has a footrest and a backrest whose angles can be adjusted.
    . The hardness of the seat cushion can be adjusted.
    . It is possible to save and reload current positions of the seat.
*/
Rectangle {
    id: root

    /*!
       Property String for checking which Button has been pressed for seat adjustment.
       Properties Int for saving values upon clicking saving button.
    */
    property string activeComponent: "default"
    property int headRestValue: 0
    property int backRestValue: 0
    property int footRestValue: 0
    property int seatHardnessValue: 0

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
                controlBackRest.value = 90;
                controlHeadRest.value = 0;
                controlFootRest.countValue = 0;
                controlSeatHardness.state = 1;
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
                controlBackRest.value = backRestValue;
                controlHeadRest.value = headRestValue;
                controlFootRest.countValue = footRestValue;
                controlSeatHardness.state = seatHardnessValue;
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
                backRestValue = controlBackRest.value;
                headRestValue = controlHeadRest.value;
                footRestValue = controlFootRest.countValue;
                seatHardnessValue = controlSeatHardness.state;
            }
        }
    }

    /*!
        Component for the menu containing Buttons
    */
    Component {
        id: menu

        Item {
            id: menuIcons

            width: 250
            height: childrenRect.height

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
                        activeComponent = "HeadRest";
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
                        activeComponent = "BackRest";
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
                        seatAnglesText.color = "grey";
                        headRestText.color = "grey";
                        footRestText.color = "white";
                        activeComponent = "footRest";
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
                        seatHardnessText.color = "grey";
                        seatHardnessText.color = "white";
                        seatHardnessText.color = "grey";
                        activeComponent = "seatHardness";
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

    /*!
        loads the menu component
    */
    Loader {
        id: leftMenu

        anchors.verticalCenter: parent.verticalCenter
        sourceComponent: menu
    }

    /*!
        Description of the UI to the user and all Seats components
        to be visible only when corresponding button is clicked
    */
    Item {
        id: description

        visible: activeComponent == "default" ? true : false
        anchors.centerIn: parent
        Text {
            text: "Please select your desired seat part \nto adjust your own comfortable position"
            color: "white"
            anchors.centerIn: parent
        }
    }

    Seats.ControlHeadRest {
        id: controlHeadRest

        anchors.centerIn: parent
        visible: activeComponent == "HeadRest" ? true : false
    }

    Seats.ControlBackRest {
        id: controlBackRest

        anchors.centerIn: parent
        visible: activeComponent == "BackRest" ? true : false
    }

    Seats.ControlFootRest {
        id: controlFootRest

        anchors.centerIn: parent
        visible: activeComponent == "footRest" ? true : false
    }

    Seats.ControlSeatHardness {
        id: controlSeatHardness

        anchors.centerIn: parent
        visible: activeComponent == "seatHardness" ? true : false
    }
}
