import QtQuick
import QtQuick.Controls.Basic
import NavalBattle
import QtQuick.Layouts

ApplicationWindow {

    id: root

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
            locGame.firstPositionIsVisible = true
            locGame.visible = true
        }

    }

    LocalGameplay{
        id: locGame

        visible: false
    }


    //RowLayout{

        // width: root.width * 0.85
        // height: root.height * 0.85
        // anchors.centerIn: root

        // GameBoard{
        //     id: gameBoard
        //     //visible: false

        //     width: root.width * 0.85
        //     height: root.height * 0.85
        //     anchors.verticalCenter: root.width / 2



        //     controller: GameController{
        //         id: controller
        //     }

        //     //width: 500
        // }
    //}






}
