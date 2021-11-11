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
import QtQuick.Controls
import QtQuick.Controls.Material
import "qrc:/quickmultieffect"

Window {
    id: mainWindow

    // Multiplier for resolution independency
    readonly property real dp: 0.2 + Math.min(width, height) / 1200

    width: 1280
    height: 720
    visible: true
    title: qsTr("QuickMultiEffect Item Switcher")
    color: "#404040"

    QtObject {
        id: settings
        property real settingsViewWidth: 100 + 150 * dp
        property int effectIndex: 0
        property int switchDuration: 1500
        property int itemSize: mainWindow.height * 0.6
    }

    Item {
        id: testItem1
        width: 1
        height: 1
    }

    Rectangle {
        id: testItem2
        anchors.fill: itemSwitcher
        color: "#d0d0d0"
        visible: false
        Image {
            anchors.fill: parent
            anchors.margins: 4
            source: "images/background.png"
        }
        Text {
            anchors.centerIn: parent
            font.pixelSize: 40 * dp
            horizontalAlignment: Text.AlignHCenter
            text: "This is the\nfirst item"
            color: "#ffffff"
            style: Text.Outline
            styleColor: "#202020"
        }
    }

    Rectangle {
        id: testItem3Content
        anchors.fill: itemSwitcher
        color: "white"
        border.width: 5
        Text {
            anchors.centerIn: parent
            font.pixelSize: 48 * dp
            horizontalAlignment: Text.AlignHCenter
            text: "This is a\nDIFFERENT\nsecond item"
            rotation: slider.value * 360
        }
        Slider {
            id: slider
            anchors.top: parent.top
            anchors.topMargin: 20 * dp
            anchors.horizontalCenter: parent.horizontalCenter
            from: 0
            to: 1
            width: parent.width * 0.8
        }
        Button {
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20 * dp
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Controls Button"
        }
    }
    ShaderEffectSource {
        // Wrap testItem3 into ShaderEffectSource so it doesn't need
        // visible = false and can be interactive.
        id: testItem3
        anchors.fill: testItem3Content
        sourceItem: testItem3Content
        hideSource: true
        visible: false
    }

    Image {
        id: testItem4
        source: "images/Built_with_Qt.png"
        anchors.fill: itemSwitcher
        visible: false
    }

    Image {
        id: testItem5
        source: "images/quit_coding.png"
        anchors.fill: itemSwitcher
        visible: false
    }

    Item {
        id: mainArea
        anchors.left: settingsView.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        PagesView {
            id: pagesView
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20 * dp
            PagesItem {
                width: pagesView.itemSize
                height: pagesView.itemSize
                source: testItem1
                text: "(EMPTY)"
                selected: itemSwitcher.currentIndex === 0
                onClicked: {
                    itemSwitcher.currentIndex = 0;
                }
            }
            PagesItem {
                width: pagesView.itemSize
                height: pagesView.itemSize
                source: testItem2
                selected: itemSwitcher.currentIndex === 1
                onClicked: {
                    itemSwitcher.currentIndex = 1;
                }
            }
            PagesItem {
                width: pagesView.itemSize
                height: pagesView.itemSize
                source: testItem3
                selected: itemSwitcher.currentIndex === 2
                onClicked: {
                    itemSwitcher.currentIndex = 2;
                }
            }
            PagesItem {
                width: pagesView.itemSize
                height: pagesView.itemSize
                source: testItem4
                selected: itemSwitcher.currentIndex === 3
                onClicked: {
                    itemSwitcher.currentIndex = 3;
                }
            }
            PagesItem {
                width: pagesView.itemSize
                height: pagesView.itemSize
                source: testItem5
                selected: itemSwitcher.currentIndex === 4
                onClicked: {
                    itemSwitcher.currentIndex = 4;
                }
            }
        }
    }
    ItemSwitcher {
        id: itemSwitcher
        anchors.centerIn: mainArea
        anchors.verticalCenterOffset: pagesView.height / 2
        width: settings.itemSize
        height: settings.itemSize
        duration: settings.switchDuration
        Component.onCompleted: {
            // Add all switchable items into switcher
            sourceItems[0] = testItem1;
            sourceItems[1] = testItem2;
            sourceItems[2] = testItem3;
            sourceItems[3] = testItem4;
            sourceItems[4] = testItem5;
            // From item is the currently selected one
            currentIndex = settings.effectIndex;
        }

        SwitchEffectBlinds {
            id: blindsEffect
            visible: settings.effectIndex == 0
            rotation: 45
        }
        SwitchEffectBlur {
            id: blurEffect
            visible: settings.effectIndex == 1
        }
        SwitchEffectHeart {
            id: heartEffect
            visible: settings.effectIndex == 2
        }
        SwitchEffectStars {
            id: starsEffect
            visible: settings.effectIndex == 3
        }
        SwitchEffectThunder {
            id: thunderEffect
            visible: settings.effectIndex == 4
        }
        SwitchEffect3DFlip {
            id: flipEffect
            visible: settings.effectIndex == 5
        }
    }

    SettingsView {
        id: settingsView
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.margins: 20
    }
}
