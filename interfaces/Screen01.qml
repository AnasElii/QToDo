import QtQuick 6.5
import QtQuick.Controls.Material 6.5
import QtQuick.Layouts 6.5
import "components"
import mainLib 1.0

// Constants
Rectangle {
    id: root

    property bool isDialogOpen: true

    // Verification of text input
    function textVerification() {
        if (toDoTextInput.text.length === 0) {
            textMiniRec.color = "#b51616";
            toDoTextInput.placeholderTextColor = "#b51616";
            return false;
        }
        return true;
    }

    function decreaseIndex(params) {
        index--;
    }

    // Title
    Text {
        id: toDoTitle

        text: qsTr("To Do")
        font.pixelSize: 25
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            margins: 0
        }
    }

    // ToDo list
    ColumnLayout {
        id: column

        // width: parent.width
        // height: 400
        spacing: 20
        anchors {
            top: toDoTitle.bottom
            left: parent.left
            right: parent.right
            bottom: addToDoButton.top
            margins: 10
            bottomMargin: 20
        }

        // Repeater of ToDo items
        Repeater {
            id: repeater

            Layout.fillWidth: true
            Layout.fillHeight: true

            // List model
            model: myListModel

            // ToDo item
            delegate: MyDoItem {
            }
        }
    }

    // Add ToDo dialog
    Rectangle {
        id: addToDoDialog

        width: parent.width
        height: 170
        anchors {
            left: parent.left
            right: parent.right
            bottom: addToDoButton.top
            margins: 10
        }

        visible: root.isDialogOpen

        color: "#e0e0e0"
        radius: 10

        // Text input
        TextField {
            id: toDoTextInput

            anchors {
                left: parent.left
                right: parent.right
                bottom: buttonsLayout.top
                leftMargin: 25
                rightMargin: 25
                bottomMargin: 10
            }

            placeholderText: qsTr("Add To Do...")
            font.pixelSize: 20
            placeholderTextColor: "#88353637"

            Rectangle {
                id: textMiniRec

                height: 3
                color: "#88353637"

                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }
            }
        }

        // Buttons layout
        RowLayout {
            id: buttonsLayout

            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                margins: 25
            }
            spacing: 25

            // Add button
            Button {
                id: addButton
                Layout.fillWidth: true
                text: qsTr("Add")

                onClicked: {
                    if (textVerification()) {

                        // Add item to list model

                        myListModel.append({
                                "index": 0,
                                "text": toDoTextInput.text
                            });
                        var count = myListModel.count;
                        myListModel.get(count - 1).index = count - 1;

                        // Clear text input
                        toDoTextInput.text = "";
                        root.isDialogOpen = false;
                        textMiniRec.color = "#88353637";
                        toDoTextInput.placeholderTextColor = "#88353637";
                    }
                }
            }

            // Cancel button
            Button {
                id: cancelButton
                Layout.fillWidth: true
                text: qsTr("Cancel")

                onClicked: {
                    toDoTextInput.text = "";
                    root.isDialogOpen = false;
                    textMiniRec.color = "#88353637";
                    toDoTextInput.placeholderTextColor = "#88353637";
                }
            }
        }
    }

    // Add ToDo button
    Button {
        id: addToDoButton

        text: qsTr("Add ToDo")
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            margins: 10
        }
        onClicked: root.isDialogOpen = !root.isDialogOpen
    }
}
