/****************************************************************************
**
** Copyright (C) 2020 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.12

Column {
    id: rootItem

    property alias text: textItem.text
    property bool show: true

    default property alias contents: contentItem.children
    property real showHideAnimationSpeed: 400

    width: settings.settingsViewWidth

    Component.onCompleted: {
        // Set initial open state
        contentItem.visible = rootItem.show;
        contentItem.opacity = rootItem.show;
        contentItemArea.height = rootItem.show ? contentItem.height : 0;
    }

    Item {
        id: lightsSettings
        width: parent.width
        height: 30
        Rectangle {
            anchors.fill: parent
            color: "#404040"
            border.width: 1
            border.color: "#808080"
            opacity: 0.4
        }
        Image {
            x: 8
            source: "images/arrow.png"
            anchors.verticalCenter: parent.verticalCenter
            rotation: rootItem.show ? 90 : 0
            Behavior on rotation {
                NumberAnimation {
                    duration: showHideAnimationSpeed
                    easing.type: Easing.InOutQuad
                }
            }
        }

        Text {
            id: textItem
            x: 30
            anchors.verticalCenter: parent.verticalCenter
            color: "#f0f0f0"
            font.bold: true
            font.pixelSize: 16 * dp
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                rootItem.show = !rootItem.show;
                if (rootItem.show) {
                    hideAnimation.stop();
                    showAnimation.start();
                } else {
                    showAnimation.stop();
                    hideAnimation.start();
                }

            }
        }
    }

    Item {
        width: 1
        height: 5
    }

    SequentialAnimation {
        id: showAnimation
        ScriptAction {
            script: contentItem.visible = true;
        }
        ParallelAnimation {
            NumberAnimation {
                target: contentItemArea
                property: "height"
                to: contentItem.height
                duration: showHideAnimationSpeed
                easing.type: Easing.InOutQuad
            }
            SequentialAnimation {
                PauseAnimation {
                    duration: showHideAnimationSpeed / 2
                }
                NumberAnimation {
                    target: contentItem
                    property: "opacity"
                    to: 1.0
                    duration: showHideAnimationSpeed / 2
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }

    SequentialAnimation {
        id: hideAnimation
        ParallelAnimation {
            NumberAnimation {
                target: contentItemArea
                property: "height"
                to: 0
                duration: showHideAnimationSpeed
                easing.type: Easing.InOutQuad
            }
            SequentialAnimation {
                NumberAnimation {
                    target: contentItem
                    property: "opacity"
                    to: 0
                    duration: showHideAnimationSpeed / 2
                    easing.type: Easing.InOutQuad
                }
                PauseAnimation {
                    duration: showHideAnimationSpeed / 2
                }
            }
        }
        ScriptAction {
            script: contentItem.visible = false;
        }
    }

    Item {
        id: contentItemArea
        width: parent.width - 10
        x: 5
        Column {
            id: contentItem
            spacing: -10
        }
    }

    Item {
        width: 1
        height: 5
    }
}
