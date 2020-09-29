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

    function resetSettings() {
        colorizeColorSelector.setValues(defaultSettings.colorizeColor.r,
                                        defaultSettings.colorizeColor.g,
                                        defaultSettings.colorizeColor.b);
        shadowColorSelector.setValues(defaultSettings.shadowColor.r,
                                      defaultSettings.shadowColor.g,
                                      defaultSettings.shadowColor.b);
    }

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
            anchors.fill: parent
            opacity: showAnimation
            visible: opacity

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

            SettingsComponentView {
                id: settingsViewGeneral
                text: qsTr("General")
                show: true
                SettingsComponentCheckBox {
                    text: "Show Shaders"
                    checked: settings.showShader
                    onToggled: {
                        settings.showShader = checked;
                    }
                }
                SettingsComponentCheckBox {
                    text: "Show Item Size"
                    checked: settings.showItemSize
                    onToggled: {
                        settings.showItemSize = checked;
                    }
                }
                SettingsComponentCheckBox {
                    text: "Padding Enabled"
                    checked: settings.paddingEnabled
                    onToggled: {
                        settings.paddingEnabled = checked;
                    }
                }
                Item {
                    width: 1
                    height: 20 * dp
                }
                SettingsComponentSlider {
                    text: qsTr("Padding Left") + ": " + value.toFixed(0)
                    value: settings.paddingRect.x
                    from: 0.0
                    to: 300
                    onMoved: {
                        settings.paddingRect.x = value;
                    }
                }
                SettingsComponentSlider {
                    text: qsTr("Padding Right") + ": " + value.toFixed(0)
                    value: settings.paddingRect.width
                    from: 0.0
                    to: 300
                    onMoved: {
                        settings.paddingRect.width = value;
                    }
                }
                SettingsComponentSlider {
                    text: qsTr("Padding Top") + ": " + value.toFixed(0)
                    value: settings.paddingRect.y
                    from: 0.0
                    to: 300
                    onMoved: {
                        settings.paddingRect.y = value;
                    }
                }
                SettingsComponentSlider {
                    text: qsTr("Padding Bottom") + ": " + value.toFixed(0)
                    value: settings.paddingRect.height
                    from: 0.0
                    to: 300
                    onMoved: {
                        settings.paddingRect.height = value;
                    }
                }
            }

            SettingsComponentView {
                text: qsTr("Color")
                show: false
                SettingsComponentSlider {
                    text: qsTr("Brightness") + ": " + value.toFixed(3)
                    showCheckbox: true
                    checked: settings.brightnessEnabled
                    onToggled: {
                        settings.brightnessEnabled = checked;
                    }
                    value: settings.brightness
                    from: -1
                    to: 1
                    onMoved: {
                        settings.brightness = value;
                    }
                }
                SettingsComponentSlider {
                    text: qsTr("Contrast") + ": " + value.toFixed(3)
                    showCheckbox: true
                    checked: settings.contrastEnabled
                    onToggled: {
                        settings.contrastEnabled = checked;
                    }
                    value: settings.contrast
                    from: -1
                    to: 1
                    onMoved: {
                        settings.contrast = value;
                    }
                }
                SettingsComponentSlider {
                    text: qsTr("Saturation") + ": " + value.toFixed(3)
                    showCheckbox: true
                    checked: settings.saturationEnabled
                    onToggled: {
                        settings.saturationEnabled = checked;
                    }
                    value: settings.saturation
                    from: -1
                    to: 1
                    onMoved: {
                        settings.saturation = value;
                    }
                }
                SettingsComponentSlider {
                    text: qsTr("Colorize") + ": " + value.toFixed(3)
                    showCheckbox: true
                    checked: settings.colorizeEnabled
                    onToggled: {
                        settings.colorizeEnabled = checked;
                    }
                    value: settings.colorize
                    from: 0
                    to: 1
                    onMoved: {
                        settings.colorize = value;
                    }
                }
                SettingsComponentColorSelector {
                    id: colorizeColorSelector
                    text: qsTr("Colorize Color")
                    width: settings.settingsViewWidth - 10
                    onValueChanged: {
                        settings.colorizeColor = value;
                    }
                }
            }
            SettingsComponentView {
                text: qsTr("Blur")
                show: false

                SettingsComponentSlider {
                    text: qsTr("Blur") + ": " + value.toFixed(3)
                    showCheckbox: true
                    checked: settings.blurEnabled
                    onToggled: {
                        settings.blurEnabled = checked;
                    }
                    value: settings.blur
                    from: 0
                    to: 1.0
                    onMoved: {
                        settings.blur = value;
                    }
                }
                SettingsComponentSlider {
                    text: qsTr("Blur Multiplier") + ": " + value.toFixed(3)
                    value: settings.blurMultiplier
                    from: 0.0
                    to: 2.0
                    onMoved: {
                        settings.blurMultiplier = value;
                    }
                }
                SettingsComponentSlider {
                    text: qsTr("Blur Max") + ": " + value.toFixed(0)
                    value: settings.blurMax
                    from: 2
                    to: 64
                    stepSize: 2
                    onMoved: {
                        settings.blurMax = value;
                    }
                }

            }
            SettingsComponentView {
                text: qsTr("Shadow")
                show: false

                SettingsComponentSlider {
                    text: qsTr("Shadow") + ": " + value.toFixed(3)
                    showCheckbox: true
                    checked: settings.shadowEnabled
                    onToggled: {
                        settings.shadowEnabled = checked;
                    }
                    value: settings.shadowOpacity
                    from: 0
                    to: 1.0
                    onMoved: {
                        settings.shadowOpacity = value;
                    }
                }
                SettingsComponentSlider {
                    text: qsTr("Shadow Blur") + ": " + value.toFixed(3)
                    value: settings.shadowBlur
                    from: 0.0
                    to: 1.0
                    onMoved: {
                        settings.shadowBlur = value;
                    }
                }
                SettingsComponentSlider {
                    text: qsTr("Shadow HorizontalOffset") + ": " + value.toFixed(1)
                    value: settings.shadowHorizontalOffset
                    from: -20.0
                    to: 20.0
                    onMoved: {
                        settings.shadowHorizontalOffset = value;
                    }
                }
                SettingsComponentSlider {
                    text: qsTr("Shadow VerticalOffset") + ": " + value.toFixed(1)
                    value: settings.shadowVerticalOffset
                    from: -20.0
                    to: 20.0
                    onMoved: {
                        settings.shadowVerticalOffset = value;
                    }
                }
                SettingsComponentSlider {
                    text: qsTr("Shadow Scale") + ": " + value.toFixed(3)
                    value: settings.shadowScale
                    from: 0.8
                    to: 1.2
                    onMoved: {
                        settings.shadowScale = value;
                    }
                }
                SettingsComponentColorSelector {
                    id: shadowColorSelector
                    text: qsTr("Shadow Color")
                    width: settings.settingsViewWidth - 10
                    onValueChanged: {
                        settings.shadowColor = value;
                    }
                }
            }
            SettingsComponentView {
                text: qsTr("Mask")
                show: false
                SettingsComponentCheckBox {
                    text: "Mask Enabled"
                    checked: settings.maskEnabled
                    onToggled: {
                        settings.maskEnabled = checked;
                    }
                }
                SettingsComponentCheckBox {
                    text: "Mask Inverted"
                    checked: settings.maskInverted
                    onToggled: {
                        settings.maskInverted = checked;
                    }
                }
                Item {
                    width: 1
                    height: 20 * dp
                }
                SettingsComponentSlider {
                    text: qsTr("Mask Lower Threshold") + ": " + value.toFixed(3)
                    value: settings.maskThresholdLow
                    from: 0.0
                    to: 1.0
                    onMoved: {
                        settings.maskThresholdLow = value;
                    }
                }
                SettingsComponentSlider {
                    text: qsTr("Mask Lower Spread") + ": " + value.toFixed(3)
                    value: settings.maskSpreadLow
                    from: 0.0
                    to: 1.0
                    onMoved: {
                        settings.maskSpreadLow = value;
                    }
                }
                SettingsComponentSlider {
                    text: qsTr("Mask Upper Threshold") + ": " + value.toFixed(3)
                    value: settings.maskThresholdUp
                    from: 0.0
                    to: 1.0
                    onMoved: {
                        settings.maskThresholdUp = value;
                    }
                }
                SettingsComponentSlider {
                    text: qsTr("Mask Upper Spread") + ": " + value.toFixed(3)
                    value: settings.maskSpreadUp
                    from: 0.0
                    to: 1.0
                    onMoved: {
                        settings.maskSpreadUp = value;
                    }
                }
            }
        }
    }
}
