import QtQuick 2.13
import QtQuick.Controls 2.1

Item {
    id: cushionHardness

    property alias state: spinBox.value

    SpinBox {
        id: spinBox

        anchors.centerIn: parent
        from: 0
        to: items.length - 1
        value: 0
        editable: true

        property var items: ["Soft", "Medium", "Hard"]

        textFromValue: function (value) {
            return items[value];
        }
    }

    Text {
        id: textLeft

        anchors {
            right: spinBox.left
            rightMargin: 50
            verticalCenter: parent.verticalCenter
        }
        text: "Soften"
        color: "White"
        font.pointSize: 10
    }

    Text {
        id: textRight

        anchors {
            left: spinBox.right
            leftMargin: 50
            verticalCenter: parent.verticalCenter
        }
        text: "Harden"
        color: "White"
        font.pointSize: 10
    }
}
