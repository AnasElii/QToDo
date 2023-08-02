import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 6.5
import mainLib 1.0

Rectangle {
    id: toDoItem

    property string itemText: text
    property int itemIndex: index
    property bool isTimerStarted: false

    height: 75
    Layout.fillWidth: true
    Layout.margins: 10
    color: "#e0e0e0"
    radius: 10
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
                myListModel.remove(myListModel.get(itemIndex), 1);
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
