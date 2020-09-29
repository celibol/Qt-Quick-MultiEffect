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
import "qrc:/quickmultieffect"

Item {
    id: rootItem
    // We expect all effects to be placed under ItemSwitcher
    property Item switcher: rootItem.parent

    property real _xPos: Math.sin(switcher.inAnimation * Math.PI * 50) * width * 0.03 * (0.5 - Math.abs(0.5 - switcher.inAnimation))
    property real _yPos: Math.sin(switcher.inAnimation * Math.PI * 35) * width * 0.02 * (0.5 - Math.abs(0.5 - switcher.inAnimation))

    anchors.fill: parent

    Image {
        id: maskImage
        source: "images/stripes.png"
        visible: false
    }

    QuickMultiEffect {
        source: switcher.fromItem
        width: parent.width
        height: parent.height
        x: rootItem._xPos
        y: rootItem._yPos
        paddingEnabled: true
        blurEnabled: true
        blur: switcher.inAnimation
        blurMax: 32
        blurMultiplier: 1.0
        opacity: switcher.outAnimation
        colorizeEnabled: true
        colorizeColor: "#f0d060"
        colorize: switcher.inAnimation

        contrastEnabled: true
        contrast: switcher.inAnimation
        brightnessEnabled: true
        brightness: switcher.inAnimation

        maskEnabled: true
        maskSource: maskImage
        maskThresholdLow: switcher.inAnimation * 0.9
        maskSpreadLow: 0.2
        maskThresholdUp: 1.0

        shadowEnabled: true
        shadowColor: "#f04000"
        shadowBlur: 1.0
        shadowOpacity: 5.0 - switcher.outAnimation * 5.0
        shadowHorizontalOffset: 0
        shadowVerticalOffset: 0
        shadowScale: 1.04

    }
    QuickMultiEffect {
        source: switcher.toItem
        width: parent.width
        height: parent.height
        x: -rootItem._xPos
        y: -rootItem._yPos
        paddingEnabled: true
        blurEnabled: true
        blur: switcher.outAnimation * 2
        blurMax: 32
        blurMultiplier: 1.0
        opacity: switcher.inAnimation * 3.0 - 1.0

        colorizeEnabled: true
        colorizeColor: "#f0d060"
        colorize: switcher.outAnimation
        contrastEnabled: true
        contrast: switcher.outAnimation
        brightnessEnabled: true
        brightness: switcher.outAnimation

        maskEnabled: true
        maskSource: maskImage
        maskThresholdLow: switcher.outAnimation * 0.6
        maskSpreadLow: 0.2
        maskThresholdUp: 1.0

        shadowEnabled: true
        shadowColor: "#f04000"
        shadowBlur: 1.0
        shadowOpacity: 5.0 - switcher.inAnimation * 5.0
        shadowHorizontalOffset: 0
        shadowVerticalOffset: 0
        shadowScale: 1.04
    }

}
