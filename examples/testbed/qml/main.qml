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

import QtQuick
import QtQuick.Window
import "qrc:/quickmultieffect"

Window {
    id: mainWindow

    // Multiplier for resolution independency
    readonly property real dp: 0.2 + Math.min(width, height) / 1200

    width: 1280
    height: 720
    minimumWidth: 600
    minimumHeight: 400
    visible: true
    title: qsTr("QuickMultiEffect Testbed")
    color: "#404040"
    // Enabled this to run the demo in fullscreen mode
    //visibility: Window.FullScreen

    Settings {
        id: settings
        onReseted: {
            settingsView.resetSettings();
        }
    }

    Settings {
        id: defaultSettings
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (resetSettingsOverlay.showAnimationProgress == 0)
                settings.animateMovement = !settings.animateMovement;
        }
        onPressed: {
            resetSettingsOverlay.startShow();
        }
        onReleased: {
            resetSettingsOverlay.stopShow();
        }
    }


    Item {
        id: mainArea
        anchors.left: settingsView.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        TestSourceItem {
            id: testSourceItem
            anchors.centerIn: parent
            width: parent.width / 2
            height: parent.height / 2
        }
        TestMaskItem {
            id: testMaskItem
            anchors.fill: testSourceItem
        }

        Rectangle {
            readonly property int margin: 2
            x: quickMultiEffect.x + quickMultiEffect.itemRect.x - margin
            y: quickMultiEffect.y + quickMultiEffect.itemRect.y - margin
            width: quickMultiEffect.itemRect.width + margin * 2
            height: quickMultiEffect.itemRect.height + margin * 2
            visible: settings.showItemSize
            color: "transparent"
            border.color: "#ffffff"
            border.width: 2
        }

        QuickMultiEffect {
            id: quickMultiEffect
            anchors.fill: testSourceItem
            source: testSourceItem
            maskSource: testMaskItem
            paddingEnabled: settings.paddingEnabled
            paddingRect: settings.paddingRect
            brightnessEnabled: settings.brightnessEnabled
            brightness: settings.brightness
            contrastEnabled: settings.contrastEnabled
            contrast: settings.contrast
            saturationEnabled: settings.saturationEnabled
            saturation: settings.saturation
            colorizeEnabled: settings.colorizeEnabled
            colorizeColor: settings.colorizeColor
            colorize: settings.colorize
            blurEnabled: settings.blurEnabled
            blur: settings.blur
            blurMax: settings.blurMax
            blurMultiplier: settings.blurMultiplier
            shadowEnabled: settings.shadowEnabled
            shadowOpacity: settings.shadowOpacity
            shadowBlur: settings.shadowBlur
            shadowHorizontalOffset: settings.shadowHorizontalOffset
            shadowVerticalOffset: settings.shadowVerticalOffset
            shadowColor: settings.shadowColor
            shadowScale: settings.shadowScale
            maskEnabled: settings.maskEnabled
            maskInverted: settings.maskInverted
            maskThresholdLow: settings.maskThresholdLow
            maskSpreadLow: settings.maskSpreadLow
            maskThresholdUp: settings.maskThresholdUp
            maskSpreadUp: settings.maskSpreadUp

            onSizeChangedSignal: {
                warningsView.showSizeWarning();
            }
            onShaderGeneratedSignal: {
                warningsView.showShaderWarning();
            }
        }
    }

    SettingsView {
        id: settingsView
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.margins: 20
        visible: settings.showSettingsView
        Component.onCompleted: {
            settings.reset();
        }
    }

    FpsItem {
        anchors.right: parent.right
    }

    ShaderView {
        id: shaderView
        visible: settings.showShader
        anchors.horizontalCenter: mainArea.horizontalCenter
        anchors.top: mainArea.top
        anchors.topMargin: 20
        text: "Fragment shader: " + quickMultiEffect.fragmentShaderString + "\nVertex shader: " + quickMultiEffect.vertexShaderString
    }

    WarningsView {
        id: warningsView
        anchors.bottom: parent.bottom
        anchors.left: settingsView.right
        anchors.leftMargin: 40
        anchors.right: parent.right
    }

    ResetSettingsOverlay {
        id: resetSettingsOverlay
        onAnimationFinished: {
            settings.reset();
        }
    }
}
