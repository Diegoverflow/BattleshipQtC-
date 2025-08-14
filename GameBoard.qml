import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import NavalBattle

Pane {

    id: root
    //padding: 10

    width: 500
    height: width

    background: null


    Layout.fillWidth: true
    Layout.fillHeight: true
    //Layout.alignment: Qt.AlignVCenter

    required property GameController controller

    property int lastClicked_X: -1
    property int lastClicked_Y: -1

    property bool attackingPhase: false

    property var shipsPositions: ({})
    property string positioningColor
    property int positioningSquaresNum
    property int clickedCells: 0

    signal positionError(string error)
    signal correctPositiong()

    //signal lastAttackWasHit()

    property var cells: ({})

    function save(){
        for(var key in shipsPositions){
            console.log("key -> " + key)
            if (shipsPositions[key].color.toString() !== "#00000000"){
                //cells[key].containShip = true
                //shipsPositions[key].color = "transparent"
                controller.addPlayerShips(key)
                console.log("saving pos: " + key)
            }
        }
    }

    component Cell: Rectangle{

        id: cellBorder
        color: "transparent"
        border.color: "darkblue"
        border.width: 1
        width: gameBoard.cellHeight
        height: width

        property alias checkText: check.text
        property int xx
        property int yy 
        property bool containShip: false //SI PUO' TOGLIERE

        Rectangle{
            id: cellArea

            anchors.fill: cellBorder
            color: "white"
            opacity: 0.3

            function findCellsToOccupy() {

                let cellsToOccupy = []
                let i
                let key
                if (xx === lastClicked_X){

                    for(i=1; i<=Math.abs(yy-lastClicked_Y); i++){
                        let found_Y
                        if (lastClicked_Y > yy){
                            found_Y = lastClicked_Y - i //yy - (i-1)
                        } else {
                            found_Y = lastClicked_Y + i //yy + i
                        }

                        let lastClicked_X_String = lastClicked_X.toString()
                        let found_Y_string = found_Y.toString()
                        key = lastClicked_X_String+"&"+found_Y_string
                        console.log(key)
                        console.log(root.shipsPositions[key].color)
                        if (root.shipsPositions[key].color.toString() !== "#00000000"){
                            cellsToOccupy = []
                            break
                        }
                        cellsToOccupy.push(key)
                    }

                }
                if (yy === lastClicked_Y){

                    for(i=1; i<=Math.abs(xx-lastClicked_X); i++){
                        let found_X
                        if (lastClicked_X > xx){
                            found_X = lastClicked_X - i
                        } else {
                            found_X = lastClicked_X + i
                        }

                        let lastClicked_Y_String = lastClicked_Y.toString()
                        let found_X_string = found_X.toString()
                        key = found_X_string+"&"+lastClicked_Y_String
                        console.log(key)
                        //console.log(shipsPositions[key].color.toString() === "#00000000" ? true : false )

                        if (shipsPositions[key].color.toString() !== "#00000000"){
                            cellsToOccupy = []
                            break
                        }
                        cellsToOccupy.push(key)
                    }

                }
                return cellsToOccupy
            }

            function goodCell(){

                if (positioningSquaresNum === 1) {
                    return true
                }

                if ((cellArea.parent.xx !== root.lastClicked_X && cellArea.parent.yy !== root.lastClicked_Y)){ //not aligned
                        //&& lastClicked_X !== -1){
                    root.clickedCells -= 1
                    root.positionError("not aligned")
                    console.log("not aligned")
                    return false
                }
                let diff_Y = Math.abs(yy-lastClicked_Y)+1
                let diff_X = Math.abs(xx-lastClicked_X)+1
                if ((xx === lastClicked_X && (diff_Y !== root.positioningSquaresNum)) //aligned but wrong distance
                        || (yy === lastClicked_Y && (diff_X !== root.positioningSquaresNum))) {
                    root.clickedCells -= 1
                    root.positionError("aligned but wrong distance")
                    console.log("aligned but wrong distance")
                    return false
                }
                let cellsToOccupy = findCellsToOccupy()
                if (cellsToOccupy.length === 0) { // collision with other ships
                    root.clickedCells -= 1
                    root.positionError("collision with other ships")
                    console.log("collision with other ships")
                    return false
                }

                return true

            }

            function colorCells(){
                if (!cellArea.goodCell()){
                    console.log("not good cell")
                    return false
                } else {
                    console.log("sono dentro")

                    if (positioningSquaresNum === 1) {
                        let x_string = xx.toString()
                        let y_string = yy.toString()
                        let key = x_string + "&" + y_string
                        root.shipsPositions[key].color = root.positioningColor
                        root.correctPositiong()
                        return true
                    }

                    let cellsToOccupy = findCellsToOccupy()
                    //console.log("")
                    let i
                    for (i=0; i<cellsToOccupy.length; i++){
                        let cellKey = cellsToOccupy[i]
                        root.shipsPositions[cellKey].color = root.positioningColor
                    }
                    root.correctPositiong()
                    return true
                }

            }

            function positioningMode(){

                if(root.positioningColor === ""){
                    console.log("ciao")
                    return
                }

                console.log("x: " + xx + " & yy: " + yy)

                root.clickedCells += 1
                let updateLastClicked

                if (clickedCells % 2 !== 0) {
                    let x_string = xx.toString()
                    let y_string = yy.toString()
                    let key = x_string + "&" + y_string
                    //console.log("--> " + root.shipsPositions[key].color.toString())
                    if (root.shipsPositions[key].color.toString() !== "#00000000"){
                        root.clickedCells -= 1
                        root.positionError("collision with other ships")
                        updateLastClicked = false
                    } else {
                        if (positioningSquaresNum === 1) {
                            updateLastClicked = cellArea.colorCells()
                            clickedCells = 0
                        } else {
                            shipSquare.color = root.positioningColor
                            updateLastClicked = true
                        }
                    }
                } else {
                    updateLastClicked = cellArea.colorCells()
                }

                if (updateLastClicked){
                    root.lastClicked_X = cellBorder.xx
                    root.lastClicked_Y = cellBorder.yy
                }




                //console.log("x: " + xx + " & y: " + yy)
                console.log("xxxx: " + lastClicked_X + " & yyyy: " + lastClicked_Y)
            }
        //}


            MouseArea{
                anchors.fill: cellArea

                onClicked: {

                    if (!root.attackingPhase){
                        cellArea.positioningMode()
                    } else {
                        let x_string = xx.toString()
                        let y_string = yy.toString()
                        let key = x_string + "&" + y_string
                        controller.attackOn(key)
                        if (controller.lastAttackWasHit){
                            shipsPositions[key].color = "red"
                        }
                    }

                }


            }

            Rectangle {
                id: shipSquare
                color: "transparent"
                anchors.centerIn: cellArea
                width: cellArea.width * 0.75
                height: cellArea.height * 0.75
            }

            Text {
                id: check
                //text: shipSquare.color.toString() //"x: " + xx + " & yy: " + yy
            }

        }

        Component.onCompleted: {
            xx = index % 10
            yy = Math.floor(index / 10)
            var x_string = xx.toString()
            var y_string = yy.toString()
            var key = x_string+"&"+y_string
            shipsPositions[key] = shipSquare
            cells[key] = cellBorder
            console.log("inizializzo --> " + key)
            console.log(cellBorder.containShip)
        }


    }


    GridView{

        id: gameBoard
        model: 100
        anchors.fill: parent

        cellHeight: parent.height / 10
        cellWidth: gameBoard.cellHeight

        delegate: Cell{
            id: cell
            checkText: index // shipSquare.color.toString()
        }

    }

    ListView {
        id: numbers
        orientation: ListView.Horizontal

        anchors.top: gameBoard.bottom

        width: root.width
        height: gameBoard.cellHeight

        model: 10
        delegate: Rectangle{

            width: gameBoard.cellHeight
            height: width

            border.color: "darkblue"
            color: "white"

            Text {
                text: index+1
                font.pixelSize: 24
                anchors.centerIn: parent
                color: "darkblue"
            }

        }
    }

    ListView {
        id: lettersView
        orientation: ListView.Vertical

        anchors.left: gameBoard.right

        width: gameBoard.cellWidth
        height: root.height

        model: 10

        property string letters: "ABCDEFGHIJ"

        function cellLetter(itemIndex: int){
            return letters[itemIndex]
        }

        delegate: Rectangle{

            width: gameBoard.cellHeight
            height: width

            border.color: "darkblue"
            color: "white"


            Text {
                text: lettersView.cellLetter(index)
                font.pixelSize: 24
                anchors.centerIn: parent
                color: "darkblue"
            }

        }
    }


}
