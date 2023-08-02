import QtQuick 6.5

Window {
    width: 320
    height: 720

    visible: true
    title: "ToDoDemo"

    ListModel {
        id: myListModel
    }

    Screen01 {
        id: mainScreen

        anchors.fill: parent
    }
}
