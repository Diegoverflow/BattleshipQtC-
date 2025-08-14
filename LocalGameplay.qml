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
        }

    }

    GameBoard{
        id: attackBoard1

        controller: gameController
        attackingPhase: true
        visible: false




    }

    GameBoard{
        id: attackBoard2

        controller: gameController
        attackingPhase: true
        visible: false
    }

}
