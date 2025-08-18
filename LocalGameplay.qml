import QtQuick
import QtQuick.Controls.Basic
import NavalBattle
import QtQuick.Layouts

Pane {

    width: parent.width
    height: parent.height

    background: null

    property bool firstPositionIsVisible: false

    GameController {

        id: gameController

        onGameIsRunningChanged: winner => {
                                    messages.text = winner
                                }

        onAttackDone: {

            if (!gameController.firstPlayerTurn) {
                passTurnTo2.enabled = true
            }
            if (gameController.firstPlayerTurn) {
                passTurnTo1.enabled = true
            }

            console.log("attack done")
        }
    }


    PlayerPositiong {
        id: positioning1
        visible: firstPositionIsVisible

        controller: gameController

        onPositioningDone: {
            positioning1.visible = false
            positioning2.visible = true
            console.log("first player turn -> " + gameController.firstPlayerTurn)
        }
    }

    PlayerPositiong {
        id: positioning2
        visible: false

        controller: gameController

        onPositioningDone: {
            positioning2.visible = false
            attackBoard1.visible = true
            console.log("first player turn -> " + gameController.firstPlayerTurn)
        }
    }



    GameBoard {
        id: attackBoard1

        controller: gameController
        attackingPhase: true
        attackLaunched: false

        visible: false

        // Label {

        //     x: 100
        //     y: 600

        //     visible: attackBoard1.visible

        //     text: "---> 1"
        // }

        onAttackError: (error) => {
                            messages.text = error
                       }

        Button {

            id: passTurnTo2

            x: 600
            y: x

            //anchors.topMargin: attackBoard1.bottom
            width: 100
            height: 50

            background: Rectangle {
                color: "blue"
                anchors.fill: parent
                radius: 10
            }

            palette.buttonText: "white"

            text: "pass turn"



            enabled: false

            visible: attackBoard1.visible

            onClicked: {
                passTurnTo2.enabled = false
                attackBoard2.visible = true
                attackBoard1.visible = false
                attackBoard2.attackLaunched = false
                messages.text = attackBoard1.visible ? "Player 1" : "Player 2"
                console.log("passing turn - switch to game board 2")
            }
        }
    }

    GameBoard {
        id: attackBoard2

        controller: gameController
        attackingPhase: true
        attackLaunched: false

        visible: false

        // Label {

        //     x: 100
        //     y: 600

        //     visible: attackBoard2.visible

        //     text: "---> 2"
        // }

        onAttackError: (error) => {
                            messages.text = error
                       }

        Button {

            id: passTurnTo1

            x: 600
            y: x

            //anchors.topMargin: attackBoard2.bottom
            width: 100
            height: 50

            background: Rectangle {
                color: "blue"
                anchors.fill: parent
                radius: 10
            }

            palette.buttonText: "white"

            text: "pass turn"

            enabled: false

            visible: attackBoard2.visible

            onClicked: {
                attackBoard1.visible = true
                attackBoard1.attackLaunched = false
                passTurnTo1.enabled = false
                attackBoard2.visible = false
                messages.text = attackBoard1.visible ? "Player 1" : "Player 2"
                console.log("passing turn - switch to game board 1")
            }
        }
    }



    //RowLayout {
        Label {
            id: messages

            anchors.top: attackBoard1.bottom
            anchors.topMargin: 60

            visible: attackBoard1.visible || attackBoard2.visible ? true : false

            width: attackBoard1.width
            height: 24

            text: attackBoard1.visible ? "Player 1" : "Player 2"
            color: "darkblue"
            font.pixelSize: 18

            Layout.fillWidth: true

            background: Rectangle {
                anchors.fill: parent
                color: "lightblue"
                opacity: 0.5
                radius: 10
            }
        }
    //}
}
