#include "display.h"

#include <QtCore/qjniobject.h>
#include <QtCore/qcoreapplication.h>

Display::Display(QObject *parent)
    : QObject{parent}
{
    connect(this, &Display::imagePathChanged,
            this, &Display::updateAndroidImagePath);
}

void Display::setImagePath(const QString &newPath)
{
    if (m_path == newPath)
        return;

    m_path = newPath;
    emit imagePathChanged();
}

QString Display::imagePath() const
{
    return m_path;
}

void Display::updateAndroidImagePath()
{
    #ifdef Q_OS_ANDROID
    QJniObject qtString = QJniObject::fromString(m_path);
    QJniObject::callStaticMethod<void>(
                    "org/qtproject/example/QGuiApp/Display",
                    "display",
                    "(Ljava/lang/String;)V",
                    qtString.object<jstring>()
        );
    #endif
}
