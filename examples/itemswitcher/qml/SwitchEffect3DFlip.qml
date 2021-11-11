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
import "qrc:/quickmultieffect"

Item {
    id: rootItem
    // We expect all effects to be placed under ItemSwitcher
    property Item switcher: rootItem.parent

    anchors.fill: parent

    QuickMultiEffect {
        source: switcher.fromItem
        width: parent.width
        height: parent.height
        x: switcher.inAnimation * rootItem.width
        paddingEnabled: true
        blurEnabled: true
        blur: switcher.inAnimation
        blurMax: 32
        blurMultiplier: 1.0
        opacity: switcher.outAnimation

        saturationEnabled: true
        saturation: -switcher.inAnimation * 1.5

        maskEnabled: true
        maskSource: Image {
            source: "images/smoke.png"
            visible: false
        }
        maskThresholdLow: switcher.inAnimation * 0.6
        maskSpreadLow: 0.1
        maskThresholdUp: 1.0 - (switcher.inAnimation * 0.6)
        maskSpreadUp: 0.1

        shadowEnabled: true
        shadowOpacity: 0.5
        shadowBlur: 0.8
        shadowVerticalOffset: 5
        shadowHorizontalOffset: 10 + (x * 0.2)
        shadowScale: 1.02

        transform: Rotation {
            origin.x: parent.width / 2
            origin.y: parent.height / 2
            axis { x: 0; y: 1; z: 0 }
            angle: switcher.inAnimation * 60
        }
        rotation: -switcher.inAnimation * 20
        scale: 1.0 + (switcher.inAnimation * 0.2)
    }

    QuickMultiEffect {
        source: switcher.toItem
        width: parent.width
        height: parent.height
        x: -switcher.outAnimation * rootItem.width
        paddingEnabled: true
        blurEnabled: true
        blur: switcher.outAnimation * 2
        blurMax: 32
        blurMultiplier: 1.0
        opacity: switcher.inAnimation

        saturationEnabled: true
        saturation: -switcher.outAnimation * 1.5

        maskEnabled: true
        maskSource: Image {
            source: "images/smoke.png"
            visible: false
        }
        maskThresholdLow: switcher.outAnimation * 0.6
        maskSpreadLow: 0.1
        maskThresholdUp: 1.0 - (switcher.outAnimation * 0.6)
        maskSpreadUp: 0.1

        shadowEnabled: true
        shadowOpacity: 0.5
        shadowBlur: 0.8
        shadowVerticalOffset: 5
        shadowHorizontalOffset: 10 + (x * 0.2)
        shadowScale: 1.02

        transform: Rotation {
            origin.x: parent.width / 2
            origin.y: parent.height / 2
            axis { x: 0; y: 1; z: 0 }
            angle: -switcher.outAnimation * 60
        }
        rotation: switcher.outAnimation * 20
        scale: 1.0 - (switcher.outAnimation * 0.4)
    }
}
