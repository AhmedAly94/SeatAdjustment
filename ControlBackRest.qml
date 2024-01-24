import "." as Seats
import QtQuick 2.13

Seats.Slider {
    id: slider

    width: 325
    enabled: true
    showText: true
    showScale: true
    from: 90
    to: 180

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
                    "Angle is  " + slider.value + "°";
                }
            }
        }
    }
}
