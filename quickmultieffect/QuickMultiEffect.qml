/******************************************************************************
**
** Copyright (C) 2020 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the Qt QuickMultiEffect module.
**
** $QT_BEGIN_LICENSE:GPL-MARKETPLACE-QT$
**
** Marketplace License Usage
** Users, who have licensed the Software under the Qt Marketplace license
** agreement, may use this file in accordance with the Qt Marketplace license
** agreement provided with the Software or, alternatively, in accordance with
** the terms contained in a written agreement between you and The Qt Company.
** For licensing terms and conditions see
** https://www.qt.io/terms-conditions/#marketplace and
** https://www.qt.io/terms-conditions. For further information use the contact
** form at https://www.qt.io/contact-us.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 or (at your option) any later version
** approved by the KDE Free Qt Foundation. The licenses are as published by
** the Free Software Foundation and appearing in the file LICENSE.GPL3
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
******************************************************************************/

// GraphicsInfo was introduced in Qt 5.8 / QtQuick 2.8.
// Disabling that, this effect should work with any Qt 5 QtQuick version.
import QtQuick 2.8
import "private"

/*!
    \qmltype QuickMultiEffect
    \inqmlmodule "qrc:/quickmultieffect"
    \since QuickMultiEffect 1.0

    \brief Combination of multiple effects in a single item.

    QuickMultiEffect is an item for adding effects into Qt Quick user interface.
    Compared to Qt Graphical Effects module, QuickMultiEffect combines multiple
    effects (blur, shadow, colorize etc.) into a single item and shader. This
    improves performance in cases where more than one effect per item is desired.
    QuickMultiEffect is designed especially for animated effects, where
    performance is more important than absolute rendering quality.

    To use QuickMultiEffect in your own application UI, follow these steps:

    \list 1

    \li Copy the \c quickmultieffect directory into your project.

    \li In your .pro file, add
        \badcode
        include(quickmultieffect/include.pri)
        \endcode
        or do the equivalent with build systems other than qmake.

    \li Add
        \badcode
        import "qrc:/quickmultieffect"
        \endcode

       and
       \badcode
       QuickMultiEffect {
           ...
       }
       \endcode
       component into your QML file.

    \li Set the \l {QuickMultiEffect}'s \e source property to the item you want
        to add an effect to.

    \li Enable the QuickMultiEffect features you want to use. These are boolean
       properties with a suffix \e Enabled, e.g. blurEnabled, contrastEnabled,
       colorizeEnabled, and so on. To improve performance, shader code will only
       be generated for features that are enabled.

    \li Tweak and/or animate the effect properties. Note that some properties are
       meant to be set beforehand and not during the animations for optimal
       performance. These are documented with \b {Performance note} comments.
    \endlist
*/

Item {
    id: rootItem

    /*!
        \qmlproperty var QuickMultiEffect::source

        Source item for the effect. This does not need to be ShaderEffectSource
        or have \c {layer.enabled} set to \c true as QuickMultiEffect will
        internally generate a ShaderEffectSource as the texture source.
    */
    property var source

    /*!
        \qmlproperty bool QuickMultiEffect::hideSource

        When enabled, source item is hidden. This is often preferred when the
        effect item replaces the source item. Another option is to set the source
        item's \e visibility property to \c false, but that disables also user
        interaction (for example, events from a MouseArea). Therefore, hiding the
        the source item may be preferred.

        By default, this property is set to \c true.
    */
    property bool hideSource: true

    /*!
        \qmlproperty bool QuickMultiEffect::paddingEnabled

        When enabled, item size is padded with paddingRect or automatically
        based on blurMax. Setting this to \c false keeps the item size as original,
        if blur/shadow is not used or the item already contains enough padding to
        fit all required content after applying the effects.

        \include notes.qdocinc performance item size

        \include notes.qdocinc performance item resize
    */
    property bool paddingEnabled: true

    /*!
        \qmlproperty rect QuickMultiEffect::paddingRect

        Set this to increase item size manually so that blur and/or shadows will fit.
        If paddingEnabled is enabled and paddingRect is not set, the item is padded
        to fit maximally blurred item based on blurMax. When enabling the shadow,
        the padding rect typically needs to take shadowHorizontalOffset and
        shadowVerticalOffset into account.

        \include notes.qdocinc performance item size

        \include notes.qdocinc performance item resize
    */
    property rect paddingRect: Qt.rect(0, 0, 0, 0)

    /*!
        \qmlproperty bool QuickMultiEffect::brightnessEnabled

        Enables the brightness effect.

        \include notes.qdocinc performance shader regen
    */
    property bool brightnessEnabled: false

    /*!
        \qmlproperty real QuickMultiEffect::brightness

        This property defines how much the source brightness is increased or
        decreased.

        The value ranges from -1.0 to 1.0. By default, the property is set to \c
        0.0 (no change).
    */
    property real brightness: 0.0

    /*!
        \qmlproperty bool QuickMultiEffect::contrastEnabled

        Enables the contrast effect.

        \include notes.qdocinc performance shader regen
    */
    property bool contrastEnabled: false

    /*!
        \qmlproperty real QuickMultiEffect::contrast

        This property defines how much the source contrast is increased or
        decreased.

        The value ranges from -1.0 to 1.0. By default, the property is set to \c
        0.0 (no change).
    */
    property real contrast: 0.0

    /*!
        \qmlproperty bool QuickMultiEffect::saturationEnabled

        Enables the saturation effect.

        \include notes.qdocinc performance shader regen
    */
    property bool saturationEnabled: false

    /*!
        \qmlproperty real QuickMultiEffect::saturation

        This property defines how much the source saturation is increased or
        decreased.

        The value ranges from -1.0 (totally desaturated) to inf. By default,
        the property is set to \c 0.0 (no change).
    */
    property real saturation: 0.0

    /*!
        \qmlproperty bool QuickMultiEffect::colorizeEnabled

        Enables the colorize effect.

        \include notes.qdocinc performance shader regen
    */
    property bool colorizeEnabled: false

    /*!
        \qmlproperty real QuickMultiEffect::colorize

        This property defines how much the source is colorized with the
        colorizeColor.

        The value ranges from 0.0 (no colorized) to 1.0 (fully colorized).
        By default, the property is set to \c 0.0 (no change).
    */
    property real colorize: 0.0

    /*!
        \qmlproperty color QuickMultiEffect::colorizeColor

        This property defines the RGBA color value which is used to
        colorize the source.

        By default, the property is set to \c  Qt.rgba(1.0, 0.0, 0.0, 1.0) (red).
    */
    property color colorizeColor: Qt.rgba(1.0, 0.0, 0.0, 1.0)

    /*!
        \qmlproperty bool QuickMultiEffect::blurEnabled

        Enables the blur effect.

        \include notes.qdocinc performance shader regen
    */
    property bool blurEnabled: false

    /*!
        \qmlproperty real QuickMultiEffect::blur

        This property defines how much blur (radius) is applied to the source.

        The value ranges from 0.0 (no blur) to 1.0 (full blur). By default,
        the property is set to \c 0.0 (no change). The amount of full blur
        is affected by blurMax and blurMultiplier.

        \b {Performance note:} If you don't need to go close to 1.0 at any point
        of blur animations, consider reducing blurMax or blurMultiplier for
        optimal performance.
    */
    property real blur: 0.0

    /*!
        \qmlproperty int QuickMultiEffect::blurMax

        This property defines the maximum pixel radius that blur with value
        1.0 will reach.

        Meaningful range of this value is from 2 (subtle blur) to 64 (high
        blur). By default, the property is set to \c 32. For the most optimal
        performance, select as small value as you need.

        \note This affects to both blur and shadow effects.

        \include notes.qdocinc performance shader regen

        \include notes.qdocinc performance item resize
    */
    property int blurMax: 32

    /*!
        \qmlproperty real QuickMultiEffect::blurMultiplier

        This property defines a multiplier for extending the blur radius.

        The value ranges from 0.0 (not multiplied) to inf. By default,
        the property is set to \c 0.0. Incresing the multiplier extends the
        blur radius, but decreases the blur quality. This is more performant
        option for a bigger blur radius than blurMax as it doesn't increase
        the amount of texture lookups.

        \note This affects to both blur and shadow effects.

        \include notes.qdocinc performance item resize
    */
    property real blurMultiplier: 0.0

    /*!
        \qmlproperty bool QuickMultiEffect::shadowEnabled

        Enables the shadow effect.

        \include notes.qdocinc performance shader regen
    */
    property bool shadowEnabled: false

    /*!
        \qmlproperty real QuickMultiEffect::shadowOpacity

        This property defines the opacity of the drop shadow.

        The value ranges from 0.0 (fully transparent) to 1.0 (fully opaque).
        By default, the property is set to \c 1.0.
    */
    property real shadowOpacity: 1.0

    /*!
        \qmlproperty real QuickMultiEffect::shadowBlur

        This property defines how much blur (radius) is applied to the shadow.

        The value ranges from 0.0 (no blur) to 1.0 (full blur). By default,
        the property is set to \c 1.0. The amount of full blur
        is affected by blurMax and blurMultiplier.

        \b {Performance note:} The most optimal way to reduce shadow blurring is
        to make blurMax smaller (if it isn't needed for item blur). Just remember
        to not adjust blurMax during animations.
    */
    property real shadowBlur: 1.0

    /*!
        \qmlproperty real QuickMultiEffect::shadowHorizontalOffset

        This property defines the horizontal offset of the shadow from the
        item center.

        The value ranges from -inf to inf. By default, the property is set
        to \c 10.0.

        \note When moving shadow position away from center and adding
        shadowBlur, you possibly also need to increase the paddingRect
        accordingly if you want the shadow to not be clipped.
    */
    property real shadowHorizontalOffset: 10

    /*!
        \qmlproperty real QuickMultiEffect::shadowVerticalOffset

        This property defines the vertical offset of the shadow from the
        item center.

        The value ranges from -inf to inf. By default,
        the property is set to \c 10.0.

        \note When moving shadow position away from center and adding
        shadowBlur, you possibly also need to increase the paddingRect
        accordingly if you want the shadow to not be clipped.
    */
    property real shadowVerticalOffset: 10

    /*!
        \qmlproperty color QuickMultiEffect::shadowColor

        This property defines the RGBA color value which is used to colorize
        the shadow. It is useful for example when a shadow is used for
        simulating a glow effect.

        By default, the property is set to \c {Qt.rgba(0.0, 0.0, 0.0, 1.0)}
        (black).
    */
    property color shadowColor: Qt.rgba(0.0, 0.0, 0.0, 1.0)

    /*!
        \qmlproperty real QuickMultiEffect::shadowScale

        This property defines the scale of the shadow. Scaling is applied from
        the center of the item.

        The value ranges from 0 to inf. By default, the property is set to
        \c 1.0.

        \note When increasing the shadowScale, you possibly also need to
        increase the paddingRect accordingly to avoid the shadow from being
        clipped.
    */
    property real shadowScale: 1.0

    /*!
        \qmlproperty bool QuickMultiEffect::maskEnabled

        Enables the mask effect.

        \include notes.qdocinc performance shader regen
    */
    property bool maskEnabled: false

    /*!
        \qmlproperty var QuickMultiEffect::maskSource

        Source item for the mask effect. Should point to ShaderEffectSource,
        item with \c {layer.enabled} set to \c true, or to an item that can be
        directly used as a texture source (e.g. \l [QML] Image). The alpha
        channel of the source item is used for masking.
    */
    property var maskSource

    /*!
        \qmlproperty real QuickMultiEffect::maskThresholdLow

        This property defines a lower threshold value for the mask pixels.
        The mask pixels that have an alpha value below this property are used
        to completely mask away the corresponding pixels from the source item.
        The mask pixels that have a higher alpha value are used to alphablend
        the source item to the display.

        The value ranges from 0.0 (alpha value 0) to 1.0 (alpha value 255). By
        default, the property is set to \c 0.0.
    */
    property real maskThresholdLow: 0.0

    /*!
        \qmlproperty real QuickMultiEffect::maskSpreadLow

        This property defines the smoothness of the mask edges near the
        maskThresholdLow. Setting higher spread values softens the transition
        from the transparent mask pixels towards opaque mask pixels by adding
        interpolated values between them.

        The value ranges from 0.0 (sharp mask edge) to 1.0 (smooth mask edge).
        By default, the property is set to \c 0.0.
    */
    property real maskSpreadLow: 0.0

    /*!
        \qmlproperty real QuickMultiEffect::maskThresholdUp

        This property defines an upper threshold value for the mask pixels.
        The mask pixels that have an alpha value below this property are used
        to completely mask away the corresponding pixels from the source item.
        The mask pixels that have a higher alpha value are used to alphablend
        the source item to the display.

        The value ranges from 0.0 (alpha value 0) to 1.0 (alpha value 255). By
        default, the property is set to \c 1.0.
    */
    property real maskThresholdUp: 1.0

    /*!
        \qmlproperty real QuickMultiEffect::maskSpreadUp

        This property defines the smoothness of the mask edges near the
        maskThresholdUp. Using higher spread values softens the transition
        from the transparent mask pixels towards opaque mask pixels by adding
        interpolated values between them.

        The value ranges from 0.0 (sharp mask edge) to 1.0 (smooth mask edge).
        By default, the property is set to \c 0.0.
    */
    property real maskSpreadUp: 0.0

    /*!
        \qmlproperty bool QuickMultiEffect::maskInverted

        This property switches the mask to the opposite side; instead of
        masking away the content outside maskThresholdLow and maskThresholdUp,
        content between them will get masked away.

        By default, the property is set to \c false.

        \include notes.qdocinc performance shader regen
    */
    property bool maskInverted: false


    // Read-only access to generated shaders. These can be used for
    // optimization, to debug the behavior and optionally implement custom
    // shader versions.
    readonly property alias fragmentShaderString: shaderItem.fragmentShader
    readonly property alias vertexShaderString: shaderItem.vertexShader

    // Read-only access to effect item rectangle. This can be used e.g. to see
    // the area item covers.
    readonly property rect itemRect: Qt.rect(shaderItem.x, shaderItem.y, shaderItem.width, shaderItem.height)


    QtObject {
        id: priv
        // *** internal properties ***

        // This increases the size of rendered item so blurred content fits there
        readonly property int itemPadding: paddingEnabled && priv.blurItemsNeeded ? blurMax * (1.2 + blurMultiplier) : 0

        readonly property rect paddingRect: paddingEnabled ? rootItem.paddingRect : Qt.rect(0, 0, 0, 0)
        // Controls if blurItems need to be generated
        readonly property bool blurItemsNeeded: (blurEnabled || shadowEnabled)
        readonly property bool generateBlurItems: rootItem.visible && priv.blurItemsNeeded
        property string shaderVersions: shaderItem._isCore ? "core" : "compatibility"
        property string blurItemsVertexShader: "qrc:/quickmultieffect/shaders/" + priv.shaderVersions + "/bluritems.vert"
        property string blurItemsFragmentShader: "qrc:/quickmultieffect/shaders/" + priv.shaderVersions + "/bluritems.frag"

        readonly property bool useBlurItem1: generateBlurItems
        readonly property bool useBlurItem2: generateBlurItems
        readonly property bool useBlurItem3: generateBlurItems && (rootItem.blurMax > 2)
        readonly property bool useBlurItem4: generateBlurItems && (rootItem.blurMax > 8)
        readonly property bool useBlurItem5: generateBlurItems && (rootItem.blurMax > 16)
        readonly property bool useBlurItem6: generateBlurItems && (rootItem.blurMax > 32)
    }

    signal shaderGeneratedSignal
    signal sizeChangedSignal

    // Initial size
    implicitWidth: source ? source.width : 100
    implicitHeight: source ? source.height : 100

    function blurWeight(v) {
        return Math.max(0.0, Math.min(1.0, 1.0 - v * 2.0));
    }

    function calculateBlurWeights(blurLod) {
        var bw1 = blurWeight(Math.abs(blurLod - 0.1));
        var bw2 = blurWeight(Math.abs(blurLod - 0.3));
        var bw3 = blurWeight(Math.abs(blurLod - 0.5));
        var bw4 = blurWeight(Math.abs(blurLod - 0.7));
        var bw5 = blurWeight(Math.abs(blurLod - 0.9));
        var bw6 = blurWeight(Math.abs(blurLod - 1.1));

        var bsum = bw1 + bw2 + bw3 + bw4 + bw5 + bw6;
        shaderItem.blurWeight1 = Qt.vector4d(bw1 / bsum, bw2 / bsum, bw3 / bsum, bw4 / bsum);
        shaderItem.blurWeight2 = Qt.vector2d(bw5 / bsum, bw6 / bsum);
    }

    function calculateShadowWeights(shadowLod) {
        var sw1 = blurWeight(Math.abs(shadowLod - 0.1));
        var sw2 = blurWeight(Math.abs(shadowLod - 0.3));
        var sw3 = blurWeight(Math.abs(shadowLod - 0.5));
        var sw4 = blurWeight(Math.abs(shadowLod - 0.7));
        var sw5 = blurWeight(Math.abs(shadowLod - 0.9));
        var sw6 = blurWeight(Math.abs(shadowLod - 1.1));

        var ssum = sw1 + sw2 + sw3 + sw4 + sw5 + sw6;
        shaderItem.shadowBlurWeight1 = Qt.vector4d(sw1 / ssum, sw2 / ssum, sw3 / ssum, sw4 / ssum);
        shaderItem.shadowBlurWeight2 = Qt.vector2d(sw5 / ssum, sw6 / ssum);
    }

    // Main source item.
    ShaderEffectSource {
        id: itemSource
        readonly property real baseWidth: sourceItem ? sourceItem.width : 1
        readonly property real baseHeight: sourceItem ? sourceItem.height : 1
        // Adjusted paddings for possible item vs. source size difference
        property real _widthMultiplier: baseWidth / rootItem.width
        property real _heightMultiplier: baseHeight / rootItem.height
        property real _xPadding: priv.itemPadding * _widthMultiplier
        property real _yPadding: priv.itemPadding * _heightMultiplier
        property rect _rect: Qt.rect(priv.paddingRect.x * _widthMultiplier,
                                     priv.paddingRect.y * _heightMultiplier,
                                     priv.paddingRect.width * _widthMultiplier,
                                     priv.paddingRect.height * _heightMultiplier)
        sourceItem: rootItem.visible ? rootItem.source : null
        width: shaderItem.width
        height: shaderItem.height
        sourceRect: Qt.rect(-_rect.x - _xPadding,
                            -_rect.y - _yPadding,
                            baseWidth + _rect.x + _rect.width + _xPadding * 2,
                            baseHeight + _rect.y + _rect.height + _yPadding * 2)
        visible: false
        hideSource: rootItem.hideSource
        smooth: true
    }

    ShaderEffectSource {
        id: blurredItemSource1
        width: Math.ceil(shaderItem.width / 64) * 64
        height: Math.ceil(shaderItem.height / 64) * 64
        sourceItem: priv.useBlurItem1 ? itemSource : null
        hideSource: rootItem.visible
        visible: false
        smooth: true
    }

    BlurItem {
        id: blurredItem1
        property var source: blurredItemSource1
        anchors.fill: blurredItemSource2
    }

    ShaderEffectSource {
        id: blurredItemSource2
        width: blurredItemSource1.width / 2
        height: blurredItemSource1.height / 2
        sourceItem: priv.useBlurItem2 ? blurredItem1 : null
        hideSource: rootItem.visible
        visible: false
        smooth: true
    }

    BlurItem {
        id: blurredItem2
        property var source: blurredItemSource2
        anchors.fill: blurredItemSource3
    }

    ShaderEffectSource {
        id: blurredItemSource3
        width: blurredItemSource2.width / 2
        height: blurredItemSource2.height / 2
        sourceItem: priv.useBlurItem3 ? blurredItem2 : null
        hideSource: rootItem.visible
        visible: false
        smooth: true
    }

    BlurItem {
        id: blurredItem3
        property var source: blurredItemSource3
        anchors.fill: blurredItemSource4
    }

    ShaderEffectSource {
        id: blurredItemSource4
        width: blurredItemSource3.width / 2
        height: blurredItemSource3.height / 2
        sourceItem: priv.useBlurItem4 ? blurredItem3 : null
        hideSource: rootItem.visible
        visible: false
        smooth: true
    }

    BlurItem {
        id: blurredItem4
        property var source: blurredItemSource4
        anchors.fill: blurredItemSource5
    }

    ShaderEffectSource {
        id: blurredItemSource5
        width: blurredItemSource4.width / 2
        height: blurredItemSource4.height / 2
        sourceItem: priv.useBlurItem5 ? blurredItem4 : null
        hideSource: rootItem.visible
        visible: false
        smooth: true
    }

    BlurItem {
        id: blurredItem5
        property var source: blurredItemSource5
        anchors.fill: blurredItemSource6
    }

    ShaderEffectSource {
        id: blurredItemSource6
        width: blurredItemSource5.width / 2
        height: blurredItemSource5.height / 2
        sourceItem: priv.useBlurItem6 ? blurredItem5 : null
        hideSource: rootItem.visible
        visible: false
        smooth: true
    }

    ShaderEffect {
        id: shaderItem
        property var src: itemSource
        property alias contrast: rootItem.contrast
        property alias brightness: rootItem.brightness
        property alias saturation: rootItem.saturation
        // Packing some properties into vec4 & vec2 for shader optimization
        property vector4d colorizeColor: Qt.vector4d(rootItem.colorizeColor.r, rootItem.colorizeColor.g,
                                                     rootItem.colorizeColor.b, rootItem.colorize)
        property alias maskSrc: rootItem.maskSource
        property vector4d mask: Qt.vector4d(rootItem.maskThresholdLow, 1.0 + rootItem.maskSpreadLow,
                                            rootItem.maskThresholdUp, 1.0 + rootItem.maskSpreadUp)
        property vector4d shadowColor: Qt.vector4d(rootItem.shadowColor.r, rootItem.shadowColor.g,
                                                   rootItem.shadowColor.b, rootItem.shadowOpacity)
        property real shadowScale: 1.0 / rootItem.shadowScale
        property vector2d shadowOffset: Qt.vector2d(rootItem.shadowHorizontalOffset / width,
                                                    rootItem.shadowVerticalOffset / height)
        // This points to center offset of item without paddings, scaled with shadowScale.
        property vector2d centerOffset: Qt.vector2d((1.0 - shadowScale) * (0.5 + 0.5 * (priv.paddingRect.x - priv.paddingRect.width) / width),
                                                    (1.0 - shadowScale) * (0.5 + 0.5 * (priv.paddingRect.y - priv.paddingRect.height) / height))

        property var blurSrc1: blurredItemSource1
        property var blurSrc2: blurredItemSource2
        property var blurSrc3: blurredItemSource3
        property var blurSrc4: blurredItemSource4
        property var blurSrc5: blurredItemSource5
        property var blurSrc6: blurredItemSource6

        // Pack blurring weights into vec4 & vec2 for shader optimization
        property vector4d blurWeight1
        property vector2d blurWeight2
        property vector4d shadowBlurWeight1
        property vector2d shadowBlurWeight2

        function calculateLod(blurAmount) {
            return Math.sqrt(blurAmount * rootItem.blurMax / 64.0) * 1.2 - 0.2;
        }

        readonly property real blurLod: calculateLod(rootItem.blur)
        readonly property real shadowLod: calculateLod(rootItem.shadowBlur)

        x: -priv.paddingRect.x - priv.itemPadding
        y: -priv.paddingRect.y - priv.itemPadding
        width: parent.width + priv.paddingRect.x + priv.paddingRect.width + (priv.itemPadding * 2)
        height: parent.height + priv.paddingRect.y + priv.paddingRect.height + (priv.itemPadding * 2)

        onWidthChanged: sizeChangedTimer.start();
        onHeightChanged: sizeChangedTimer.start();

        Timer {
            id: sizeChangedTimer
            interval: 0
            onTriggered: {
                if (rootItem.visible) {
                    console.debug("QuickMultiEffect: Item resized.");
                    rootItem.sizeChangedSignal();
                }
            }
        }

        // *** private ***
        // Shader generation supports both compatibility (#version 150) and
        // core (#version 330) GLSL versions
        readonly property bool _isCore: GraphicsInfo.profile === GraphicsInfo.OpenGLCoreProfile
        readonly property string _attribute: _isCore ? "in " : "attribute "
        // Vertex "varying"
        readonly property string _vvarying: _isCore ? "out " : "varying "
        // Fragment "varying"
        readonly property string _fvarying: _isCore ? "in " : "varying "
        readonly property string _texture: _isCore ? "texture" : "texture2D"
        readonly property string _fragColor: _isCore ? "fragColor" : "gl_FragColor"

        readonly property string vShader:
        {
            var s = "";
            if (_isCore) {
                s += "#version 330 core\n";
            }

            s += "uniform highp mat4 qt_Matrix;\n";
            if (rootItem.shadowEnabled) {
                s += "uniform lowp float shadowScale;
uniform lowp vec2 shadowOffset;
uniform lowp vec2 centerOffset;\n";
                s += _vvarying + "highp vec2 shadowTexCoord;\n";
            }

            s += _attribute + "highp vec4 qt_Vertex;\n";
            s += _attribute + "highp vec2 qt_MultiTexCoord0;\n";
            s += _vvarying + "highp vec2 texCoord;\n";

            s += "void main() {
    texCoord = qt_MultiTexCoord0;\n";
            if (rootItem.shadowEnabled) {
                s += "    shadowTexCoord = qt_MultiTexCoord0 - shadowOffset;\n";
                s += "    shadowTexCoord = (shadowTexCoord * shadowScale) + centerOffset;\n";
            }
            s += "    gl_Position = qt_Matrix * qt_Vertex;
}";
            return s;
        }

        readonly property string fShader:
        {
            var s = "";

            if (_isCore) {
                s += "#version 330 core\nout vec4 fragColor;\n";
            }

            s += _fvarying + "highp vec2 texCoord;
uniform sampler2D src;
uniform lowp float qt_Opacity;\n";
            if (rootItem.contrastEnabled)
                s += "uniform lowp float contrast;\n";
            if (rootItem.brightnessEnabled)
                s += "uniform lowp float brightness;\n";
            if (rootItem.saturationEnabled)
                s += "uniform lowp float saturation;\n";
            if (rootItem.colorizeEnabled)
                s += "uniform lowp vec4 colorizeColor;\n";
            if (priv.useBlurItem1)
                s += "uniform sampler2D blurSrc1;\n";
            if (priv.useBlurItem2)
                s += "uniform sampler2D blurSrc2;\n";
            if (priv.useBlurItem3)
                s += "uniform sampler2D blurSrc3;\n";
            if (priv.useBlurItem4)
                s += "uniform sampler2D blurSrc4;\n";
            if (priv.useBlurItem5)
                s += "uniform sampler2D blurSrc5;\n";
            if (priv.useBlurItem6)
                s += "uniform sampler2D blurSrc6;\n";

            if (rootItem.blurEnabled) {
                s += "uniform lowp vec4 blurWeight1;\n";
                if (priv.useBlurItem5)
                    s += "uniform lowp vec2 blurWeight2;\n"
            }
            if (rootItem.maskEnabled) {
                s += "uniform sampler2D maskSrc;\nuniform lowp vec4 mask;\n";
            }
            if (rootItem.shadowEnabled) {
                s += _fvarying + "highp vec2 shadowTexCoord;
uniform lowp vec4 shadowColor;\n";
                s += "uniform lowp vec4 shadowBlurWeight1;\n";
                if (priv.useBlurItem5)
                    s += "uniform lowp vec2 shadowBlurWeight2;\n";
            }

            s += "void main() {
    highp vec4 color;\n";

            // Blur
            if (rootItem.blurEnabled) {
                s += "    color = " + _texture + "(blurSrc1, texCoord) * blurWeight1[0];
    color += " + _texture + "(blurSrc2, texCoord) * blurWeight1[1];\n";
                if (priv.useBlurItem3)
                    s += "    color += " + _texture + "(blurSrc3, texCoord) * blurWeight1[2];\n";
                if (priv.useBlurItem4)
                    s += "    color += " + _texture + "(blurSrc4, texCoord) * blurWeight1[3];\n";
                if (priv.useBlurItem5)
                    s += "    color += " + _texture + "(blurSrc5, texCoord) * blurWeight2[0];\n";
                if (priv.useBlurItem6)
                    s += "    color += " + _texture + "(blurSrc6, texCoord) * blurWeight2[1];\n";
            } else {
                s += "    color = " + _texture + "(src, texCoord);\n";
            }

            // Contrast
            if (rootItem.contrastEnabled) {
                s += "    color.rgb = (color.rgb - 0.5 * color.a) * (1.0 + contrast) + 0.5 * color.a;\n";
            }
            // Brightness
            if (rootItem.brightnessEnabled) {
                s += "    color.rgb += brightness * color.a;\n";
            }

            if (rootItem.saturationEnabled || rootItem.colorizeEnabled) {
                // Calculate gray only once for features that need it
                s += "    lowp float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));\n";
            }

            // Colorize
            if (rootItem.colorizeEnabled) {
                s += "    color.rgb = gray * colorizeColor.rgb * colorizeColor.a + color.rgb * (1.0 - colorizeColor.a);\n";
            }

            // Saturation
            if (rootItem.saturationEnabled) {
                s += "    color.rgb = mix(vec3(gray), color.rgb, 1.0 + saturation);\n";
            }

            // Shadow
            if (rootItem.shadowEnabled) {
                s += "    lowp float shadow = 0.0;
    shadow = " + _texture + "(blurSrc1, shadowTexCoord).a * shadowBlurWeight1[0];
    shadow += " + _texture + "(blurSrc2, shadowTexCoord).a * shadowBlurWeight1[1];\n";
                if (priv.useBlurItem3)
                    s += "    shadow += " + _texture + "(blurSrc3, shadowTexCoord).a * shadowBlurWeight1[2];\n";
                if (priv.useBlurItem4)
                    s += "    shadow += " + _texture + "(blurSrc4, shadowTexCoord).a * shadowBlurWeight1[3];\n";
                if (priv.useBlurItem5)
                    s += "    shadow += " + _texture + "(blurSrc5, shadowTexCoord).a * shadowBlurWeight2[0];\n";
                if (priv.useBlurItem6)
                    s += "    shadow += " + _texture + "(blurSrc6, shadowTexCoord).a * shadowBlurWeight2[1];\n";
                s += "    shadow *= shadowColor.a;
    lowp float aa = (1.0 - color.a) * (1.0 - shadow);
    color.rgb = mix(shadowColor.rgb * shadow, color.rgb, color.a + aa);
    color.a = 1.0 - aa;\n";
            }

            // Mask
            if (rootItem.maskEnabled) {
                s += "    lowp float alphaMask = " + _texture + "(maskSrc, texCoord).a;
    lowp float m1 = smoothstep(mask[0] * mask[1] - (mask[1] - 0.999), mask[0] * mask[1], alphaMask);
    lowp float m2 = smoothstep((1.0 - mask[2]) * mask[3] - (mask[3] - 0.999), (1.0 - mask[2]) * mask[3], (1.0 - alphaMask));\n";
                if (rootItem.maskInverted)
                    s += "    color *= (1.0 - m1 * m2);\n";
                else
                    s += "    color *= m1 * m2;\n";
            }

            s += "    " + _fragColor + " = color * qt_Opacity;\n";
            s += "}";
            return s;
        }


        fragmentShader: fShader
        vertexShader: vShader

        onStatusChanged: {
            if (rootItem.visible && status == ShaderEffect.Compiled) {
                console.debug("QuickMultiEffect: Shader generated.");
                rootItem.shaderGeneratedSignal();
            }
        }

        Component.onCompleted: {
            calculateBlurWeights(blurLod);
            calculateShadowWeights(shadowLod);
        }
        onBlurLodChanged: {
            calculateBlurWeights(blurLod);
        }
        onShadowLodChanged: {
            calculateShadowWeights(shadowLod);
        }
    }
}
