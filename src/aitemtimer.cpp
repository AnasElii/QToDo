#include "aitemtimer.h"

AItemTimer::AItemTimer(QObject *parent) : QObject{parent}
{
    m_timelapse = new QTimer{this};
    connect(m_timelapse, &QTimer::timeout, this, &AItemTimer::onTimerTimeout);
}

QTimer *AItemTimer::timelapse() const
{
    return m_timelapse;
}

QString AItemTimer::elapsedTime() const
{
    qDebug() << "Elapsed time: " << m_elapsedTimer.elapsed() / 1000 << " seconds";
    return QString::number(m_elapsedTimer.elapsed() / 1000); // Convert milliseconds to seconds as QString
}

void AItemTimer::start()
{
    qDebug() << "Timer Started";
    m_timelapse->start();
    m_elapsedTimer.start(); // Start the elapsed timer
}

void AItemTimer::stop()
{
    m_timelapse->stop();
    m_elapsedTimer.invalidate(); // Invalidate the elapsed timer
}

void AItemTimer::onTimerTimeout()
{
    qDebug() << "on Timer Timeout";

    // m_timelapse->stop();
    emit elapsedTimeChanged();
}
