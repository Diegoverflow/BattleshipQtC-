import QtQuick
import QtQuick.Controls.Basic
import NavalBattle

Pane {

    width: parent.width
    height: parent.height

    background: null

    property bool firstPositionIsVisible: false


    GameController{

        id: gameController

        onGameIsRunningChanged: (winner) => {
                                    console.log(winner)
                                }

        onAttackDone: {

            if(gameController.firstPlayerTurn){
                passTurnTo2.enabled = true

            }
            if(!gameController.firstPlayerTurn){
                passTurnTo1.enabled = true
            }

            console.log("attack done")
        }


    }



    PlayerPositiong{
        id: positioning1
        visible: firstPositionIsVisible

        controller: gameController


        onPositioningDone: {
            positioning1.visible = false
            positioning2.visible = true
        }

    }


    PlayerPositiong{
        id: positioning2
        visible: false

        controller: gameController

        onPositioningDone: {
            positioning2.visible = false
            attackBoard1.visible = true
            console.log("first player turn -> " + gameController.firstPlayerTurn)
        }



    }



    GameBoard{
        id: attackBoard1

        controller: gameController
        attackingPhase: true
        attackLaunched: false


        visible: false

        Label{

            x: 100
            y: 600

            visible: attackBoard1.visible

            text: "---> 1"
        }

        Button{

            id: passTurnTo2

            x: 600
            y: x

            //anchors.topMargin: attackBoard1.bottom

            width: 100
            height: 50

            background: Rectangle{
                color: "blue"
                anchors.fill: parent
            }

            text: "pass turn"

            enabled: false

            visible: attackBoard1.visible

            onClicked: {
                passTurnTo2.enabled = false
                attackBoard2.visible = true
                attackBoard1.visible = false
                attackBoard2.attackLaunched = false
                console.log("passing turn - switch to game board 2")
            }


        }

    }





    GameBoard{
        id: attackBoard2



        controller: gameController
        attackingPhase: true
        attackLaunched: false

        visible: false

        Label{

            x: 100
            y: 600

            visible: attackBoard2.visible

            text: "---> 2"
        }

        Button{

            id: passTurnTo1

            x: 600
            y: x
            //anchors.topMargin: attackBoard2.bottom

            width: 100
            height: 50

            background: Rectangle{
                color: "blue"
                anchors.fill: parent
            }

            text: "pass turn"

            enabled: false

            visible: attackBoard2.visible

            onClicked: {
                attackBoard1.visible = true
                attackBoard1.attackLaunched = false
                passTurnTo1.enabled = false
                attackBoard2.visible = false
                console.log("passing turn - switch to game board 1")
            }

        }

    }





}
