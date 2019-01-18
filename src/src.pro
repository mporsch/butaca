TEMPLATE = app
QT += declarative webkit network
TARGET = "butaca"
DEPENDPATH += .
INCLUDEPATH += .

# although the app doesn't use meegotouch by itself
# linking against it removes several style warnings
CONFIG += meegotouch

# enable booster
CONFIG += qt-boostable qdeclarative-boostable

# booster flags
QMAKE_CXXFLAGS += -fPIC -fvisibility=hidden -fvisibility-inlines-hidden
QMAKE_LFLAGS += -pie -rdynamic

# # Use share-ui interface
CONFIG += shareuiinterface-maemo-meegotouch mdatauri

!simulator {
    LIBS += -lmdeclarativecache
}

PACKAGEVERSION = $$system(head -n 1 ../qtc_packaging/debian_harmattan/changelog | grep -o [0-9].[0-9].[0-9])
DEFINES += "PACKAGEVERSION=\\\"$$PACKAGEVERSION\\\""

SOURCES += main.cpp \
    theaterlistmodel.cpp \
    movie.cpp \
    theatershowtimesfetcher.cpp \
    sortfiltermodel.cpp \
    customnetworkaccessmanagerfactory.cpp \
    controller.cpp \
    imagesaver.cpp \
    movielistmodel.cpp \
    cinema.cpp

HEADERS += \
    theaterlistmodel.h \
    movie.h \
    theatershowtimesfetcher.h \
    sortfiltermodel.h \
    customnetworkaccessmanagerfactory.h \
    controller.h \
    imagesaver.h \
    movielistmodel.h \
    cinema.h

OTHER_FILES += \
    qml/main.qml \
    qml/WelcomeView.qml \
    qml/SearchView.qml \
    qml/PersonView.qml \
    qml/GenresView.qml \
    qml/ButacaToolBar.qml \
    qml/MultipleMoviesView.qml \
    qml/MultipleMoviesDelegate.qml \
    qml/Header.qml \
    qml/NoContentItem.qml \
    qml/CastView.qml \
    qml/FilmographyView.qml \
    qml/ListSectionDelegate.qml \
    qml/TheatersView.qml \
    qml/SettingsView.qml \
    qml/AboutView.qml \
    qml/FavoriteDelegate.qml \
    qml/MovieView.qml \
    qml/MyRatingIndicator.qml \
    qml/MyMoreIndicator.qml \
    qml/MyListDelegate.qml \
    qml/MyEntryHeader.qml \
    qml/MyModelPreviewer.qml \
    qml/storage.js \
    qml/butacautils.js \
    qml/constants.js \
    resources/movie-placeholder.svg \
    resources/person-placeholder.svg \
    resources/butaca.svg \
    resources/tmdb-logo.png \
    resources/indicator-rating-inverted-star.svg \
    qml/MediaGalleryView.qml \
    qml/ZoomableImage.qml \
    qml/MyGalleryPreviewer.qml \
    qml/MyModelFlowPreviewer.qml \
    qml/MyTextExpander.qml \
    qml/moviedbwrapper.js \
    qml/ShowtimesView.qml \
    qml/FavoritesView.qml \
    qml/ListsView.qml \
    qml/JSONListModel.qml \
    qml/jsonpath.js \
    qml/TvView.qml

RESOURCES += \
    res.qrc

CODECFORTR = UTF-8
TRANSLATIONS += \
    l10n/butaca.es.ts \
    l10n/butaca.en.ts \
    l10n/butaca.de.ts \
    l10n/butaca.fi.ts \
    l10n/butaca.fr_FR.ts \
    l10n/butaca.ro.ts \
    l10n/butaca.tr.ts \
    l10n/butaca.pt_PT.ts \
    l10n/butaca.pt_BR.ts \
    l10n/butaca.cs.ts \
    l10n/butaca.it_IT.ts \
    l10n/butaca.vi.ts \
    l10n/butaca.en_GB.ts \
    l10n/butaca.nl.ts \
    l10n/butaca.ru.ts \
    l10n/butaca.sv.ts \
    l10n/butaca.zh_CN.ts \
    l10n/butaca.ca.ts

unix {
    #VARIABLES
    isEmpty(PREFIX) {
        PREFIX = /opt/$${TARGET}
    }
    BINDIR = $$PREFIX/bin
    DATADIR =$$PREFIX/share

    DEFINES += DATADIR=\\\"$$DATADIR\\\" PKGDATADIR=\\\"$$PKGDATADIR\\\"

    #MAKE INSTALL

    INSTALLS += target desktop icon64 splash

    target.path =$$BINDIR

    desktop.path = /usr/share/applications
    desktop.files += $${TARGET}.desktop

    icon64.path = $$DATADIR/icons/
    icon64.files += ../data/icon-l-$${TARGET}.png

    splash.path = $$DATADIR/
    splash.files += ../data/butaca-splash.jpg
}

# Rule for regenerating .qm files for translations (missing in qmake
# default ruleset, ugh!)
#
updateqm.input = TRANSLATIONS
updateqm.output = ${QMAKE_FILE_PATH}/${QMAKE_FILE_BASE}.qm
updateqm.commands = lrelease ${QMAKE_FILE_IN} -qm ${QMAKE_FILE_OUT}
updateqm.CONFIG += no_link
QMAKE_EXTRA_COMPILERS += updateqm
PRE_TARGETDEPS += compiler_updateqm_make_all
