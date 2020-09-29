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

Item {
    id: rootItem

    property bool show: true
    property real showAnimation: show ? 1 : 0

    width: settings.settingsViewWidth
    x: -(width + 30) * (1 - showAnimation) + 20

    Behavior on showAnimation {
        NumberAnimation {
            duration: 400
            easing.type: Easing.InOutQuad
        }
    }

    // Open/close button
    Item {
        width: 30 * dp
        height: 30 * dp
        anchors.left: parent.right
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.topMargin: -10
        Rectangle {
            anchors.fill: parent
            color: "#404040"
            opacity: 0.4
            border.width: 1
            border.color: "#808080"
        }

        Image {
            anchors.centerIn: parent
            source: "images/arrow.png"
            rotation: rootItem.showAnimation * 180
        }
        MouseArea {
            anchors.fill: parent
            anchors.margins: -30 * dp
            onClicked: {
                rootItem.show = !rootItem.show;
            }
        }
    }

    // Background
    Rectangle {
        anchors.fill: scrollView
        opacity: showAnimation ? 0.6 : 0
        visible: opacity
        anchors.margins: -10
        color: "#202020"
        border.color: "#808080"
        border.width: 1
    }

    ScrollView {
        id: scrollView
        anchors.fill: parent
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.interactive: false
        clip: true
        Column {
            id: settingsArea
            width: rootItem.width
            opacity: showAnimation
            visible: opacity
            spacing: 8 * dp

            Item {
                width: 1
                height: 20 * dp
            }
            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
                width: parent.width * 0.8
                height: width * 0.25
                source: "images/Built_with_Qt_RGB_logo.png"
            }
            Item {
                width: 1
                height: 28 * dp
            }
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Switching Effects")
                font.pixelSize: 20 * dp
                font.bold: true
                color: "#f0f0f0"
            }
            SettingsComponentButton {
                text: "Blinds"
                selected: settings.effectIndex === 0
                onClicked: {
                    settings.effectIndex = 0;
                }
            }
            SettingsComponentButton {
                text: "Blurry"
                selected: settings.effectIndex === 1
                onClicked: {
                    settings.effectIndex = 1;
                }
            }
            SettingsComponentButton {
                text: "Heart"
                selected: settings.effectIndex === 2
                onClicked: {
                    settings.effectIndex = 2;
                }
            }
            SettingsComponentButton {
                text: "Stars"
                selected: settings.effectIndex === 3
                onClicked: {
                    settings.effectIndex = 3;
                }
            }
            SettingsComponentButton {
                text: "Thunder"
                selected: settings.effectIndex === 4
                onClicked: {
                    settings.effectIndex = 4;
                }
            }
            SettingsComponentButton {
                text: "3D Flip"
                selected: settings.effectIndex === 5
                onClicked: {
                    settings.effectIndex = 5;
                }
            }
            Item {
                width: 1
                height: 10
            }

            SettingsComponentSlider {
                text: qsTr("Animation Duration") + ": " + value.toFixed(0) + " ms"
                value: settings.switchDuration
                from: 500
                to: 5000
                onMoved: {
                    settings.switchDuration = value;
                }
            }
            SettingsComponentSlider {
                text: qsTr("Animation Time") + ": " + (value * settings.switchDuration).toFixed(0) + " ms"
                value: itemSwitcher.inAnimation
                from: 0
                to: 1
                onMoved: {
                    itemSwitcher.inAnimation = value;
                }
            }
        }
    }
}
