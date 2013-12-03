TARGET = unityapplicationplugin
TEMPLATE = lib

QT       += core quick dbus
QT       += qml-private core-private v8-private # for QMLProfiler integration
QT       += gui-private # annoyingly needed by included NativeInterface
CONFIG   += link_pkgconfig plugin

# CONFIG += c++11 # only enables C++0x
QMAKE_CXXFLAGS = -std=c++11 -fvisibility=hidden -fvisibility-inlines-hidden
QMAKE_CXXFLAGS_RELEASE += -Werror     # so no stop on warning in debug builds
QMAKE_LFLAGS = -std=c++11 -Wl,-no-undefined

PKGCONFIG += mircommon mirserver glib-2.0 upstart-app-launch-1

INCLUDEPATH += ../../../platforms/mirserver
LIBS += -L../../../platforms/mirserver -lqpa-mirserver
QMAKE_RPATHDIR += $$[QT_INSTALL_PLUGINS]/platforms # where libqpa-mirserver.so is installed

TARGET = $$qtLibraryTarget($$TARGET)
uri = Unity.Application

SOURCES += application_manager.cpp \
    application.cpp \
    desktopfilereader.cpp \
    plugin.cpp \
    applicationscreenshotprovider.cpp \
    dbuswindowstack.cpp \
    taskcontroller.cpp \
    mirsurfacemanager.cpp \
    ubuntukeyboardinfo.cpp \
    qsgmirsurfacenode.cpp \
    mirsurfaceitem.cpp \
    mirbuffersgtexture.cpp

HEADERS += application_manager.h \
    application.h \
    desktopfilereader.h \
    applicationscreenshotprovider.h \
    dbuswindowstack.h \
    taskcontroller.h \
    mirsurfacemanager.h \
    ubuntukeyboardinfo.h \
    /usr/include/unity/shell/application/ApplicationManagerInterface.h \
    /usr/include/unity/shell/application/ApplicationInfoInterface.h \
    qsgmirsurfacenode.h \
    mirsurfaceitem.h \
    mirbuffersgtexture.h

installPath = $$[QT_INSTALL_IMPORTS]/Unity-Mir/$$replace(uri, \\., /)

QML_FILES = qmldir ApplicationImage.qml OSKController.qml
qml_files.path = $$installPath
qml_files.files = $$QML_FILES

target.path = $$installPath

INSTALLS += target qml_files