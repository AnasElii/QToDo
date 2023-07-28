import QtQuick 6.5
import QtQuick.Controls.Material 6.5
import QtQuick.Layouts 6.5
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

    ListModel {
        id: myListModel

        function createListElement(index) {
            return {
                "text": toDoTextInput.text,
                "index": index
            };
        }
    }

    // ToDo list
    Column {
        id: column

        width: 200
        height: 400
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

            anchors.fill: parent
            // List model
            model: myListModel

            // ToDo item
            delegate: Rectangle {
                id: toDoItem

                property string itemText: text
                property int itemIndex: index
                property bool isTimerStarted: false

                height: 75
                color: "#e0e0e0"
                radius: 10
                anchors {
                    left: parent.left
                    right: parent.right
                    leftMargin: 10
                    rightMargin: 10
                }
                clip: true

                // ToDo item layout
                Rectangle {
                    id: chekBoxRec

                    color: "#e0e0e0"
                    anchors {
                        left: parent.left
                        right: deletButtonRec.left
                        top: parent.top
                        bottom: parent.bottom

                        topMargin: 10
                        bottomMargin: 10
                        rightMargin: 10
                        leftMargin: 10
                    }

                    // ToDo item checkbox
                    CheckBox {
                        id: checkBox

                        anchors {
                            left: parent.left
                            top: parent.top
                            bottom: parent.bottom
                            leftMargin: 10
                        }

                        onCheckedChanged: {
                            if (checkBox.checked) {
                                checkBox.checked = true;
                                checkBoxText.color = "#88353637";
                                checkBoxText.font.strikeout = true;
                                timer.stop();
                            } else {
                                checkBoxText.color = "#000";
                                checkBoxText.font.strikeout = false;
                                checkBox.checked = false;
                                timer.start();
                            }
                        }
                    }

                    MouseArea {
                        id: mouseArea

                        width: checkBoxText.width
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.left: checkBox.right

                        // ToDo item text
                        Text {
                            id: checkBoxText

                            anchors {
                                verticalCenter: parent.verticalCenter
                                left: checkBox.right
                                rightMargin: 10
                                leftMargin: 10
                            }
                            text: itemText
                            font.pointSize: 22
                        }

                        onClicked: {
                            if (!checkBox.checked) {
                                checkBox.checked = true;
                                checkBoxText.color = "#88353637";
                                checkBoxText.font.strikeout = true;
                                timer.stop();
                            } else {
                                checkBoxText.color = "#000";
                                checkBoxText.font.strikeout = false;
                                checkBox.checked = false;
                                timer.start();
                            }
                        }
                    }
                }

                // Delete button
                Rectangle {
                    id: deletButtonRec
                    width: 60
                    radius: 10
                    color: "#ffffff"

                    anchors {
                        right: parent.right
                        top: parent.top
                        bottom: parent.bottom

                        topMargin: 10
                        bottomMargin: 10
                        rightMargin: 10
                    }
                    Image {
                        source: "qrc:/mainLib/resources/icons/icons8_close_480px_2.png"
                        width: 40
                        height: 40
                        anchors.centerIn: parent
                    }
                    Button {
                        opacity: 0
                        anchors.fill: parent

                        onClicked: {
                            myListModel.remove(itemIndex);
                            timer.stop();
                        }
                    }
                }

                // Timer
                AItemTimer {
                    id: timer

                    Component.onCompleted: {
                        timer.start();
                    }
                }

                // Elapsed time text
                Text {
                    id: elapsedTimeText

                    anchors {
                        left: parent.left
                        right: parent.right
                        bottom: parent.bottom
                        margins: 10
                    }
                    text: "Elapsed Time: " + timer.elapsedTime + " seconds"
                }
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
                        var index = myListModel.count;
                        myListModel.append(myListModel.createListElement(index));
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
