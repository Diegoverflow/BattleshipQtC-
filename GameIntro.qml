import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Pane {

    id: root
    anchors.centerIn: parent

    background: Rectangle{
        color: "blue"
        opacity: 0.5
    }

    ColumnLayout {


        Label {
            id: greetings
            text: "Welcome to Diego's Naval Battle"

        }

        Button {
            text: "Start"

            palette.buttonText: "white"

            Layout.alignment: Qt.AlignHCenter

            background: Rectangle{
                color: "darkblue"
            }

            onClicked: {
                console.log("Game starting..")
                root.visible = !root.visible
            }

        }

    }


}
