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
import QtQuick.Window 2.12
import QtGraphicalEffects 1.12
import "qrc:/quickmultieffect"

Window {
    id: mainWindow

    // Multiplier for resolution independency
    readonly property real dp: 0.2 + Math.min(width, height) / 1200

    // Size of a single item
    property real itemSize: 256
    // How many effects are applied, 1-4
    // 1: blur, 2: +desaturate, 3: +shadow, 4: +mask
    property int effectsAmount: 4
    // Amount of items to render
    property int items: 15
    // When false QuickMultiEffect is used, when true GraphicalEffects is used.
    property bool showGraphicalEffect: false

    property real animation1: 0.0
    property real animation2: 0.0
    property bool animationRunning: true

    visible: true
    width: 1280
    height: 720
    title: qsTr("QuickMultiEffect EffectsBench")
    color: "#404040"

    SequentialAnimation on animation1 {
        loops: Animation.Infinite
        paused: !mainWindow.animationRunning
        NumberAnimation {
            to: 1.0
            duration: 2000
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            to: 0.0
            duration: 2000
            easing.type: Easing.InOutQuad
        }
    }

    NumberAnimation on animation2 {
        loops: Animation.Infinite
        paused: !mainWindow.animationRunning
        duration: 1000 * items
        from: 0
        to: Math.PI * 2
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            mainWindow.animationRunning = !mainWindow.animationRunning;
        }
    }

    Rectangle {
        id: effectTypeButton
        z: 2
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 10
        width: 200
        height: 40
        color: "#d0d0d0"
        border.color: "#000000"
        border.width: 1
        Text {
            anchors.centerIn: parent
            text: mainWindow.showGraphicalEffect ? "Qt Graphical Effects"
                                                 : "QuickMultiEffect"
            font.pixelSize: 16
            color: "#202020"
        }
        MouseArea {
            anchors.fill: parent
            anchors.margins: -10
            onClicked: {
                mainWindow.showGraphicalEffect = !mainWindow.showGraphicalEffect;
            }
        }
    }

    Item {
        id: testSourceItem
        anchors.centerIn: parent
        width: mainWindow.itemSize
        height: mainWindow.itemSize
        layer.enabled: true
        visible: false
        Image {
            anchors.fill: parent
            anchors.margins: 30
            fillMode: Image.PreserveAspectFit
            source: "images/Built_with_Qt.png"
        }
    }

    Image {
        id: testMaskItem
        source: "mask.png"
        visible: false
    }

    Repeater {
        id: repeater
        model: mainWindow.items
        Item {
            readonly property real posX: (index - (mainWindow.items - 1) / 2) / mainWindow.items
            readonly property real posY: Math.sin(animation2 * (index + 1))
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: posX * mainWindow.width * 0.6
            anchors.verticalCenterOffset: posY * mainWindow.height * 0.2
            width: testSourceItem.width
            height: testSourceItem.height
            QuickMultiEffect {
                anchors.fill: parent
                visible: !mainWindow.showGraphicalEffect
                source: testSourceItem
                paddingEnabled: false
                blurEnabled: true
                blurMax: 16
                blur: 1.0 - mainWindow.animation1
                saturationEnabled: effectsAmount > 1
                saturation: -1.0 * mainWindow.animation1
                shadowEnabled: effectsAmount > 2
                shadowHorizontalOffset: 10 - 20 * mainWindow.animation1
                shadowVerticalOffset: 10
                shadowBlur: 1.0
                maskEnabled: effectsAmount > 3
                maskSource: testMaskItem
                maskThresholdLow: mainWindow.animation1 * 0.8
                maskSpreadLow: 0.2
            }

            Item {
                anchors.fill: parent
                visible: mainWindow.showGraphicalEffect

                FastBlur {
                    id: effect1
                    anchors.fill: parent
                    source: testSourceItem
                    transparentBorder: false
                    radius: 16 * (1.0 - mainWindow.animation1)
                    visible: effectsAmount == 1
                }
                Desaturate {
                    id: effect2
                    anchors.fill: parent
                    source: effectsAmount > 1 ? effect1 : null
                    visible: effectsAmount == 2
                    desaturation: mainWindow.animation1
                }
                DropShadow {
                    id: effect3
                    anchors.fill: parent
                    z: -1
                    source: effectsAmount > 2 ? effect2 : null
                    // DropShadow is applied for already blurred item so
                    // blur amounts don't fully match with QuickMultiEffect.
                    samples: 8
                    horizontalOffset: 10 - 20 * mainWindow.animation1
                    verticalOffset: 10
                    visible: effectsAmount == 3
                }
                ThresholdMask {
                    id: effect4
                    anchors.fill: parent
                    source: effectsAmount > 3 ? effect3 : null
                    maskSource: testMaskItem
                    threshold: mainWindow.animation1 * 0.8
                    spread: 0.2
                    visible: effectsAmount == 4
                }
            }
        }
    }

    FpsItem {
        id: fpsItem
        anchors.right: parent.right
    }
}
