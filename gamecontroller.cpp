#include "gamecontroller.h"

GameController::GameController(QObject *parent)
    : QObject{parent}
{}

list<string> GameController::fisrtPlayerShips() const
{
    return m_fisrtPlayerShips;
}


// void GameController::setFisrtPlayerShips(const list<string> &newFisrtPlayerShips)
// {
//     if (m_fisrtPlayerShips == newFisrtPlayerShips)
//         return;
//     m_fisrtPlayerShips = newFisrtPlayerShips;
//     emit fisrtPlayerShipsChanged();
// }

list<string> GameController::secondPlayerShips() const
{
    return m_secondPlayerShips;
}

void GameController::addPlayerShips(QString position)
{
    if (_firstPlayerTurn){
        m_fisrtPlayerShips.push_front(position.toStdString());
        if (m_fisrtPlayerShips.size() == 25){
            _firstPlayerTurn = !_firstPlayerTurn;
        }
    } else{
        m_secondPlayerShips.push_front(position.toStdString());
        if (m_secondPlayerShips.size() == 25){
            _firstPlayerTurn = !_firstPlayerTurn;
        }
    }
}

// void GameController::setSecondPlayerShip(const list<string> &newSecondPlayerShip)
// {
//     m_secondPlayerShip = newSecondPlayerShip;
// }

bool GameController::gameIsRunning() const
{
    return m_gameIsRunning;
}

void GameController::setGameIsRunning(bool newGameIsRunning)
{
    if (m_gameIsRunning == newGameIsRunning)
        return;
    m_gameIsRunning = newGameIsRunning;
    //emit gameIsRunningChanged();
}



void GameController::attackOn(QString position)
{
    if(_firstPlayerTurn){
        if(attackIssuccessful(position.toStdString(), m_secondPlayerShips)){
            _firstPlayerMissingHitsToWin -= 1;
            //emit this->shipHit(position);
            if(_firstPlayerMissingHitsToWin == 0){
                emit this->gameIsRunningChanged("first player is the winner");
                setGameIsRunning(false);
            }
        }
    } else {
        if(attackIssuccessful(position.toStdString(), m_fisrtPlayerShips)){
            _secondPlayerMissingHitsToWin -= 1;
            //emit this->shipHit(position);
            if(_secondPlayerMissingHitsToWin == 0){
                emit this->gameIsRunningChanged("second player is the winner");
                setGameIsRunning(false);
            }
        }
    }
    this->setFirstPlayerTurn(!this->_firstPlayerTurn);
    emit this->attackDone();
}

bool GameController::attackIssuccessful(string attackCoords, list<string> attackedShips)
{
    foreach (string enemyLocation, attackedShips) {
        if(attackCoords == enemyLocation){
            m_lastAttackWasHit = true;
            return true;
        }
    }
    m_lastAttackWasHit = false;
    return false;
}

bool GameController::lastAttackWasHit() const
{
    return m_lastAttackWasHit;
}

bool GameController::firstPlayerTurn() const
{
    return _firstPlayerTurn;
}

void GameController::setFirstPlayerTurn(bool newFirstPlayerTurn)
{
    if (_firstPlayerTurn == newFirstPlayerTurn)
        return;
    _firstPlayerTurn = newFirstPlayerTurn;
    emit firstPlayerTurnChanged();
}
