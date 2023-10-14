import QtQuick 
import QtQuick.Controls 
import QtQuick.Layouts 
import QtQuick.Effects 

import mainLib

Item {
    id: profileImagePage

//    property string profileImage: ""

    function accepted(){
        console.log("Button Clicked");
//        profileImagePage.profileImage = fdProfileImage.file;
        myDisplay.setImagePath(fdProfileImage.file);
    }

    Display{
        id: myDisplay
    }

    ColumnLayout {
        id: columnInput

        width: parent.width
        anchors.centerIn: parent
        spacing: 20

        Text {
            id: textTitle

            Layout.columnSpan: 2
            Layout.alignment: Qt.AlignHCenter
            Layout.fillHeight: true

            font {
                pixelSize: 25
                family: "Texta"
                styleName: "Bold"
            }

            color: "#646464"
            text: qsTr("Profile Image")
        }

        Rectangle {
            id: rcProfileWrapper

            width: 150
            height: 150
            color: "#000"
            radius: width / 2

            // Profile Picture

            MouseArea {
                id: maUpdateImage
                anchors.fill: parent

                onClicked: {
                    console.log("Profile Image Updated");

                    //MARK: FILE DIALOG OPEN
                    fdProfileImage.onAccepted.connect(accepted);
                    fdProfileImage.open();
                }
            }
        }
    }
}
