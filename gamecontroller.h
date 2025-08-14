#ifndef GAMECONTROLLER_H
#define GAMECONTROLLER_H

#include <QObject>
#include <qqml.h>

using namespace std;

class GameController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool gameIsRunning READ gameIsRunning WRITE setGameIsRunning NOTIFY gameIsRunningChanged FINAL)
    Q_PROPERTY(list<string> fisrtPlayerShips READ fisrtPlayerShips /*WRITE setFisrtPlayerShips*/ CONSTANT)
    Q_PROPERTY(list<string> secondPlayerShips READ secondPlayerShips /*WRITE setSecondPlayerShip*/ CONSTANT)
    Q_PROPERTY(bool lastAttackWasHit READ lastAttackWasHit CONSTANT)
    QML_ELEMENT

public:
    explicit GameController(QObject *parent = nullptr);

    list<string> fisrtPlayerShips() const;
    //void setFisrtPlayerShips(const list<string> &newFisrtPlayerShips);

    list<string> secondPlayerShips() const;
    //void setSecondPlayerShip(const list<string> &newSecondPlayerShip);

    bool gameIsRunning() const;
    void setGameIsRunning(bool newGameIsRunning);


    bool lastAttackWasHit() const;

public slots:
    void addPlayerShips(QString position);
    void attackOn(QString position);
    //void shipHit(QString message);

private:
    bool attackIssuccessful(string attackCoords, list<string> attackedShips);

signals:
    //void fisrtPlayerShipsChanged();
    void gameIsRunningChanged(QString message);
    void shipHit(QString message);

private:
    list<string> m_fisrtPlayerShips;
    list<string> m_secondPlayerShips;
    bool m_gameIsRunning;
    int _firstPlayerMissingHitsToWin = 25;
    int _secondPlayerMissingHitsToWin = 25;
    bool _firstPlayerTurn = false;
    bool m_lastAttackWasHit = false;
};

#endif // GAMECONTROLLER_H
