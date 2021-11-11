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
import QtQuick.Controls
import QtQuick.Controls.Material

Item {
    id: rootItem

    Material.theme: Material.Dark
    Material.accent: Material.LightGreen

    Image {
        anchors.centerIn: parent
        width: parent.width / 2
        height: parent.height / 2
        sourceSize.width: width
        sourceSize.height: height
        source: "images/Built_with_Qt.png"
        fillMode: Image.PreserveAspectFit
        SequentialAnimation on anchors.verticalCenterOffset {
            loops: Animation.Infinite
            paused: !settings.animateMovement
            NumberAnimation {
                to: 50
                duration: 2000
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                to: -50
                duration: 2000
                easing.type: Easing.InOutQuad
            }
        }
    }
    Text {
        font.pixelSize: 50
        font.bold: true
        text: "TESTING"
        color: "white"
    }
    Image {
        source: "images/warning.png"
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        mipmap: true
        SequentialAnimation on scale {
            loops: Animation.Infinite
            paused: !settings.animateMovement
            NumberAnimation {
                to: 0.4
                duration: 3000
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                to: 1.0
                duration: 1000
                easing.type: Easing.OutBack
            }
        }

    }
    Rectangle {
        width: parent.width * 0.2
        height: width
        anchors.top: parent.top
        anchors.topMargin: width * 0.2
        anchors.right: parent.right
        anchors.rightMargin: width * 0.2
        color: "#808080"
        border.color: "#f0f0f0"
        border.width: 2
        radius: width * 0.1
        SequentialAnimation on opacity {
            paused: !settings.animateMovement
            loops: Animation.Infinite
            NumberAnimation {
                to: 0.0
                duration: 2000
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                to: 1.0
                duration: 2000
                easing.type: Easing.InOutQuad
            }
        }

        NumberAnimation on rotation {
            paused: !settings.animateMovement
            loops: Animation.Infinite
            from: 0
            to: 360
            duration: 10000
        }
    }

    Column {
        anchors.right: parent.right
        anchors.rightMargin: width * 0.2
        anchors.bottom: parent.bottom
        Button {
            id: button
            text: "Controls Button"
            Material.theme: Material.Light
        }
        Slider {
            width: button.width
        }
    }
}

