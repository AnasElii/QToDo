import QtQuick
import Qt.labs.platform

import mainLib

Window {
    id: root

    width: 320
    height: 720
    visible: true
    title: "ToDoDemo"

    ListModel {
        id: myListModel
    }

    ProfileImagePage {
        id: profileImagePage

        anchors.fill: parent
    }

    FileDialog{
        id: fdProfileImage
        fileMode: FileDialog.OpenFile
        folder: StandardPaths.writableLocation(StandardPaths.PicturesLocation)
        nameFilters: ["Image Files (*.png *.jpeg *.jpg)", "(*.png)", "(*.jpeg *.jpg)"]
    }

}
