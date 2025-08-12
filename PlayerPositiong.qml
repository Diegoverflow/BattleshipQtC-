import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

Pane {
    
    id: root

    width: 700
    height: 700

    background: null

    property bool positiong: true
    //property bool lastPositionIsCorrect: false
    property var selectedShipContour: null
    property var selectedShip
    property int totNumOfPieces: 11
        //aircraftCarrier.numOfPieces + battleship.numOfPieces + cruiser.numOfPieces + destroyer.numOfPieces + submarine.numOfPieces
    

    component Line: Rectangle {
        height: 2
        width: 180
        color: "darkblue"
    }

    component ShipInfos: ColumnLayout {

        id: shipInfos

        property int numsOfSquares
        property string shipColor: "blue"

        property alias shipName: title.text
        //property string shipName

        property int numOfPieces
        //property alias contourRect: contour





        Text {
            id: title
            color: "darkblue"
            font.bold: true
            font.pixelSize: 18
        }

        Rectangle {

            id: contour

            color: "transparent"
            opacity: 0.5
            border.color: "darkblue"

            radius: 10

            width: 170
            height: 40

            //spacing 10
            ListView {

                anchors.centerIn: parent
                //Layout.alignment: Qt.AlignVCenter
                model: shipInfos.numsOfSquares
                width: contour.width - 20
                height: contour.height - 20

                orientation: ListView.Horizontal
                spacing: 10

                delegate: Rectangle {

                    id: shipSquare
                    color: shipInfos.shipColor

                    //anchors.rightMargin: 10
                    width: 20
                    height: width
                }
            }

            function shipsButtonFunc(){

                if (selectedShipContour !== null) {
                    selectedShipContour.color = "transparent";
                }
                contour.color = "lightgrey";
                selectedShipContour = contour;
                gameBoard.positioningColor = contour.parent.shipColor
                gameBoard.positioningSquaresNum = contour.parent.numsOfSquares
                root.selectedShip = parent
                console.log(parent.shipName)
                //console.log(contour.parent.shipColor)
            }
            
            MouseArea{
                anchors.fill: contour
                onClicked: {
                    contour.shipsButtonFunc()
                    //var ciaox = gameBoard.lastClicked_X
                }
                enabled: shipInfos.numOfPieces > 0 ? true : false
            }
            
        }

        Text {
            id: remaining
            color: "darkblue"
            font.pixelSize: 12
            text: "Remaining pieces: " + shipInfos.numOfPieces
        }




    }


    component PositioningCommands: Pane {

        width: 200
        height: 500
        Layout.alignment: Qt.AlignVCenter

        background: Rectangle {

            color: "white"
            radius: 10
            anchors.fill: parent
        }


        ScrollView {

            anchors.fill: parent
            //Layout.alignment: Qt.AlignVCenter


            ColumnLayout {

                spacing: 10

                //padding: 10
                ShipInfos {

                    id: aircraftCarrier
                    numOfPieces: 1
                    shipName: "Aircraft Carrier"
                    numsOfSquares: 5
                    shipColor: "orange"
                }


                ShipInfos {

                    id: battleship
                    numOfPieces: 1
                    shipName: "Battleship"
                    numsOfSquares: 4
                    shipColor: "yellow"
                    anchors.top: aircraftCarrier.bottom
                }

                ShipInfos {

                    id: cruiser
                    numOfPieces: 2
                    shipName: "Cruiser"
                    numsOfSquares: 3
                    shipColor: "green"
                    anchors.top: battleship.bottom
                }

                ShipInfos {

                    id: destroyer
                    numOfPieces: 3
                    shipName: "Destroyer"
                    numsOfSquares: 2
                    shipColor: "purple"
                    anchors.top: cruiser.bottom
                }

                ShipInfos {

                    id: submarine
                    numOfPieces: 4
                    shipName: "Submarine"
                    numsOfSquares: 1
                    anchors.top: destroyer.bottom
                }

                Button {

                    id: save

                    width: 170
                    height: 40

                    text: "Save"

                    property bool piecesAreFinished: root.totNumOfPieces > 0 ? false : true

                    enabled: save.piecesAreFinished

                    background: Rectangle {
                        anchors.fill: parent
                        color: save.piecesAreFinished ? "green" : "lightgreen"
                        radius: 10
                    }

                    onClicked: {
                        console.log("Save")
                        gameBoard.swithAttackingMode()
                    }

                }


            }
        }
    }


    // Label{
    //     Layout.alignment: Qt.AlignVCenter
    //     text: "i am trying to align"

    //     background: Rectangle {
    //         color: "white"
    //     }
    // }

    //RowLayout {





        PositioningCommands {
            id: commmands
            //Layout.alignment: Qt.AlignVCenter
        }

        GameBoard {
            id: gameBoard
            width: 450
            anchors.left: commmands.right

            onCorrectPositiong: {
                root.selectedShip.numOfPieces = root.selectedShip.numOfPieces - 1
                root.totNumOfPieces -= 1
                if (root.selectedShip.numOfPieces === 0) {
                    gameBoard.positioningColor = ""
                    root.selectedShipContour.color = "red"
                }
            }

            onPositionError: (error) => {
                messages.text = error
            }


        }

        //RowLayout {
            Label {
                id: messages

                anchors.top: commmands.bottom
                anchors.topMargin: 30

                width: root.width
                height: 76

                text: "To place a ship, select one with the correspondig button under its name,\nthen click on the board the first and the last square where you want your ship to be.\nClick the \"Save\" button under the ships when you finish all the available pieces."
                color: "darkblue"
                font.pixelSize: 18

                Layout.fillWidth: true

                background: Rectangle{
                    anchors.fill: parent
                    color: "lightblue"
                    opacity: 0.5
                    radius: 10
                }

            }
        //}


    //}
}
