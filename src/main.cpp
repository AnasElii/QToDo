#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDebug>

#include "aitemtimer.h"

int main(int argc, char *argv[])
{
    QGuiApplication application(argc, argv);
    QQmlApplicationEngine engine;

    application.setApplicationVersion("1.0.0");

    // Registering the AItemTimer class
    AItemTimer aItemTimer;
    engine.rootContext()->setContextProperty("aItemTimer", &aItemTimer);

    const QUrl url(u"qrc:/mainLib/interfaces/main.qml"_qs);
    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreated, &application, [url](QObject *obj, const QUrl &objUrl)
        {
        if(!obj && objUrl == url)
            QGuiApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    qDebug() << "Applicaiton name: " << QGuiApplication::applicationName()
             << " | Applicaiton version: " << QGuiApplication::applicationVersion()
             << " | Platform name: " << QGuiApplication::platformName()
             << " | Platform name: " << application.platformName()
             << " | Device pixel ratio: " << application.devicePixelRatio();

    return application.exec();
}