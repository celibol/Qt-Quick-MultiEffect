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

QtObject {
    id: rootItem

    // Emitted when settings are reseted to default
    signal reseted

    // When adding settings here remember to add them also into reset()

    // *** General settings - No UI for these ***
    // Change to false to not show settings view at all
    property bool showSettingsView: true
    property real settingsViewWidth: 100 + 150 * dp
    property bool animateMovement: true
    property bool showShader: false
    property bool showItemSize: false

    property bool paddingEnabled: true
    property rect paddingRect: Qt.rect(0, 0, 0, 0)

    property bool brightnessEnabled: true
    property real brightness: 0.0
    property bool contrastEnabled: true
    property real contrast: 0.0
    property bool saturationEnabled: true
    property real saturation: 0.0
    property bool colorizeEnabled: true
    property color colorizeColor: Qt.rgba(1.0, 0.0, 0.0, 1.0)
    property real colorize: 0.0

    property bool blurEnabled: true
    property real blur: 0.0
    property int blurMax: 32
    property real blurMultiplier: 0.0

    property bool shadowEnabled: true
    property real shadowOpacity: 1.0
    property real shadowBlur: 1.0
    property real shadowHorizontalOffset: 10
    property real shadowVerticalOffset: 5
    property color shadowColor: Qt.rgba(0.0, 0.0, 0.0, 1.0)
    property real shadowScale: 1.0

    property bool maskEnabled: true
    property bool maskInverted: false
    property real maskThresholdLow: 0.0
    property real maskSpreadLow: 0.0
    property real maskThresholdUp: 1.0
    property real maskSpreadUp: 0.0

    function reset() {
        paddingEnabled = defaultSettings.paddingEnabled;
        paddingRect = defaultSettings.paddingRect;

        brightnessEnabled = defaultSettings.brightnessEnabled;
        brightness = defaultSettings.brightness;
        contrastEnabled = defaultSettings.contrastEnabled;
        contrast = defaultSettings.contrast;
        saturationEnabled = defaultSettings.saturationEnabled;
        saturation = defaultSettings.saturation;
        colorizeEnabled = defaultSettings.colorizeEnabled;
        colorizeColor = defaultSettings.colorizeColor;
        colorize = defaultSettings.colorize;

        blurEnabled = defaultSettings.blurEnabled;
        blur = defaultSettings.blur;
        blurMax = defaultSettings.blurMax;
        blurMultiplier = defaultSettings.blurMultiplier;

        shadowEnabled = defaultSettings.shadowEnabled;
        shadowOpacity = defaultSettings.shadowOpacity;
        shadowBlur = defaultSettings.shadowBlur;
        shadowHorizontalOffset = defaultSettings.shadowHorizontalOffset;
        shadowVerticalOffset = defaultSettings.shadowVerticalOffset;
        shadowColor = defaultSettings.shadowColor;
        shadowScale = defaultSettings.shadowScale;

        maskEnabled = defaultSettings.maskEnabled;
        maskInverted = defaultSettings.maskInverted;
        maskThresholdLow = defaultSettings.maskThresholdLow;
        maskSpreadLow = defaultSettings.maskSpreadLow;
        maskThresholdUp = defaultSettings.maskThresholdUp;
        maskSpreadUp = defaultSettings.maskSpreadUp;

        rootItem.reseted();
    }
}
