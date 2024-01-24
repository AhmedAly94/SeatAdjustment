import QtQuick 2.13
import QtQuick.Controls 2.1

Item {
    id: root

    property alias value: spin.value

    SpinBox {
        id: spin

        anchors.centerIn: parent
        from: 0
        to: 90
        value: 0
        editable: true
    }

    Text {
        id: textLeft

        anchors {
            right: spin.left
            rightMargin: 50
            verticalCenter: parent.verticalCenter
        }

        text: "Retract"
        color: "White"
        font.pointSize: 10
    }

    Text {
        id: textRight

        anchors {
            left: spin.right
            leftMargin: 50
            verticalCenter: parent.verticalCenter
        }

        text: "Extend"
        color: "White"
        font.pointSize: 10
    }
}
