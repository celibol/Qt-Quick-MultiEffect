uniform lowp sampler2D source;
uniform lowp float qt_Opacity;
varying highp vec2 texCoord0;
varying highp vec2 texCoord1;
varying highp vec2 texCoord2;
varying highp vec2 texCoord3;

void main() {
    highp vec4 sourceColor = (texture2D(source, texCoord0) + texture2D(source, texCoord1) +
                              texture2D(source, texCoord2) + texture2D(source, texCoord3)) / 4.0;
    gl_FragColor = sourceColor * qt_Opacity;
}
