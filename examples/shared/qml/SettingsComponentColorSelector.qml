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
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

Column {
    id: rootItem

    property alias text: textItem.text
    readonly property color value: Qt.rgba(colorRed, colorGreen, colorBlue, 1.0)
    readonly property real colorRed: sliderRed.value
    readonly property real colorGreen: sliderGreen.value
    readonly property real colorBlue: sliderBlue.value
    readonly property real itemWidth: (rootItem.width / 3) - itemMargin
    readonly property real itemMargin: 4
    readonly property real colorBarHeight: 4

    // Use this to set the initial values
    function setValues(r, g, b) {
        sliderRed.value = r;
        sliderGreen.value = g;
        sliderBlue.value = b;
    }

    Material.theme: Material.Dark
    Material.accent: Material.LightGreen
    spacing: -12
    width: 200

    Text {
        id: textItem
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#f0f0f0"
        font.pixelSize: 14 * dp
    }
    Item {
        width: 1
        height: 36
    }

    Row {
        x: itemMargin / 2
        spacing: itemMargin
        opacity: rootItem.enabled ? 1.0 : 0.2
        Column {
            Rectangle {
                width: rootItem.itemWidth
                height: colorBarHeight
                border.width: 1
                border.color: "#202020"
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.0; color: Qt.rgba(0.0, colorGreen, colorBlue, 1.0) }
                    GradientStop { position: 1.0; color: Qt.rgba(1.0, colorGreen, colorBlue, 1.0) }
                }
                Text {
                    id: textItemRed
                    anchors.centerIn: parent
                    color: "#f0f0f0"
                    style: Text.Outline
                    styleColor: "#000000"
                    text: "R: " + Math.ceil(sliderRed.value * 255)
                    font.pixelSize: 14 * dp
                }
            }
            Slider {
                id: sliderRed
                width: rootItem.itemWidth
                value: 0
                from: 0
                to: 1
            }
        }
        Column {
            Rectangle {
                width: rootItem.itemWidth
                height: colorBarHeight
                border.width: 1
                border.color: "#202020"
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.0; color: Qt.rgba(colorRed, 0.0, colorBlue, 1.0) }
                    GradientStop { position: 1.0; color: Qt.rgba(colorRed, 1.0, colorBlue, 1.0) }
                }
                Text {
                    id: textItemGreen
                    anchors.centerIn: parent
                    color: "#f0f0f0"
                    style: Text.Outline
                    styleColor: "#000000"
                    text: "G: " + Math.ceil(sliderGreen.value * 255)
                    font.pixelSize: 14 * dp
                }
            }
            Slider {
                id: sliderGreen
                width: rootItem.itemWidth
                value: 0
                from: 0
                to: 1
            }
        }
        Column {
            Rectangle {
                width: rootItem.itemWidth
                height: colorBarHeight
                border.width: 1
                border.color: "#202020"
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.0; color: Qt.rgba(colorRed, colorGreen, 0.0, 1.0) }
                    GradientStop { position: 1.0; color: Qt.rgba(colorRed, colorGreen, 1.0, 1.0) }
                }
                Text {
                    id: textItemBlue
                    anchors.centerIn: parent
                    color: "#f0f0f0"
                    style: Text.Outline
                    styleColor: "#000000"
                    text: "B: " + Math.ceil(sliderBlue.value * 255)
                    font.pixelSize: 14 * dp
                }
            }
            Slider {
                id: sliderBlue
                width: rootItem.itemWidth
                value: 0
                from: 0
                to: 1
            }
        }
    }
}
