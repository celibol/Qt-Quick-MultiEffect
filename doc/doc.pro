TEMPLATE = aux

CONFIG += prepare_docs
QMAKE_DOCS = $$PWD/qtquickmultieffect.qdocconf

QTDIR = $$[QT_HOST_PREFIX]
exists($$QTDIR/.qmake.cache): \
    QMAKE_DOCS_OUTPUTDIR = $$QTDIR/doc/qtquickmultieffect
else: \
    QMAKE_DOCS_OUTPUTDIR = $$OUT_PWD/qtquickmultieffect
