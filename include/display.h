#ifndef DISPLAY_H
#define DISPLAY_H

#include <QObject>
#include <QQmlEngine>

class Display : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit Display(QObject *parent = nullptr);

    Q_INVOKABLE QString imagePath() const;
    Q_INVOKABLE void setImagePath(const QString &imagePath);

signals:
    void imagePathChanged();

private slots:
    void updateAndroidImagePath();

private:
    QString m_path;

};

#endif // DISPLAY_H
