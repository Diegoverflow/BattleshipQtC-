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
        visible: false
    }

    // GameBoard{
    //     id: gameBoard
    //     //visible: false
    //     width: 350
    // }

    PlayerPositiong{
        id: settings
        //visible: false
    }

}
