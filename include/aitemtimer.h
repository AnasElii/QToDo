#ifndef AITEMTIMER_H
#define AITEMTIMER_H
#include <QObject>
#include <QQmlEngine>
#include <QString>
#include <QElapsedTimer> // Include QElapsedTimer
#include <QTimer>
#include <QDebug>

class AItemTimer : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QTimer *timeLapse READ timelapse NOTIFY timeLapseChanged)
    Q_PROPERTY(QString elapsedTime READ elapsedTime NOTIFY elapsedTimeChanged) // Add this line
    QML_ELEMENT
public:
    AItemTimer(QObject *parent = nullptr);

    QTimer *timelapse() const;
    QString elapsedTime() const; // Add this function declaration

signals:
    void timeLapseChanged();
    void elapsedTimeChanged(); // Add this signal declaration

public slots:
    void start();
    void stop();

private slots:
    void onTimerTimeout();

private:
    QTimer *m_timelapse;
    QElapsedTimer m_elapsedTimer;
};

#endif // AITEMTIMER_H
