#include "aitemtimer.h"

AItemTimer::AItemTimer(QObject *parent) : QObject{parent}, m_elapsedTime(0)
{
    m_timelapse = new QTimer{this};
    m_timelapse->setInterval(1000);
    connect(m_timelapse, &QTimer::timeout, this, &AItemTimer::onTimerTimeout);
}

QTimer *AItemTimer::timelapse() const
{
    return m_timelapse;
}

QString AItemTimer::elapsedTime() const
{
    return QString::number(m_elapsedTime);
}

void AItemTimer::start()
{
    qDebug() << "Timer Started";
    m_timelapse->start();
}

void AItemTimer::stop()
{
    m_timelapse->stop();
}

void AItemTimer::onTimerTimeout()
{
    qDebug() << "on Timer Timeout";
    qDebug() << "Elapsed time: " << ++m_elapsedTime << " seconds";

    emit elapsedTimeChanged();
}
