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
import QtQuick.Timeline
import "qrc:/quickmultieffect"

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("QuickMultiEffect Qt Design Studio Tester")
    color: "#202020"

    Image {
        id: sourceItem
        anchors.centerIn: parent
        width: 300
        height: 300
        fillMode: Image.PreserveAspectFit
        source: "Built_with_Qt.png"
    }

    QuickMultiEffect {
        id: quickMultiEffect
        blurMax: 64
        shadowColor: "#ffffff"
        shadowVerticalOffset: 0
        shadowHorizontalOffset: 0
        contrastEnabled: true
        contrast: 1.0
        shadowEnabled: true
        shadowBlur: 0.4
        shadowOpacity: 0.8
        source: sourceItem
        anchors.fill: sourceItem
        MouseArea {
            anchors.fill: parent
            onClicked: timelineAnimation.restart();
        }
    }

    Timeline {
        id: timeline
        animations: [
            TimelineAnimation {
                id: timelineAnimation
                from: 0
                duration: 1000
                to: 1000
                loops: Animation.Infinite
                running: true
            }
        ]
        endFrame: 1000
        enabled: true
        startFrame: 0

        KeyframeGroup {
            target: quickMultiEffect
            property: "shadowBlur"
            Keyframe {
                value: 0.4
                frame: 0
            }

            Keyframe {
                value: 1
                frame: 500
            }

            Keyframe {
                value: 0.4
                frame: 1000
            }
        }

        KeyframeGroup {
            target: quickMultiEffect
            property: "contrast"
            Keyframe {
                value: 0
                frame: 0
            }

            Keyframe {
                value: 0.8
                frame: 500
            }

            Keyframe {
                value: 0
                frame: 1000
            }
        }
    }
}

/*##^##
Designer {
    D{i:2;timeline_expanded:true}D{i:4}
}
##^##*/
