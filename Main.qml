import QtQuick
import QtQuick.Controls.Basic

ApplicationWindow {
    width: 750
    height: width
    visible: true
    title: qsTr("Battleship")

    background: Image {
        id: background
        source: "assets/water.jpg"
        fillMode: Image.Stretch
    }

    GameIntro{
        id: gameIntro

        onStartPlay: {
            positioning1.visible = true
        }

    }

    // GameBoard{
    //     id: gameBoard
    //     //visible: false
    //     width: 350
    // }

    PlayerPositiong{
        id: positioning1
        visible: false

        onPositioningDone: {
            positioning1.visible = false
            positioning2.visible = true
        }

    }


    PlayerPositiong{
        id: positioning2
        visible: false

        onPositioningDone: {
             positioning2.visible = false
        }

    }


}
