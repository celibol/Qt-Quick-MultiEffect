# Add this into include path
INCLUDEPATH += $$PWD/

load(qt_parts)

doc.file = doc/doc.pro
SUBDIRS += doc
