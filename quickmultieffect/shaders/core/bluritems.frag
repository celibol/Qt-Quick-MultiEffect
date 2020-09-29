#version 330 core
uniform lowp sampler2D source;
uniform lowp float qt_Opacity;
in highp vec2 texCoord0;
in highp vec2 texCoord1;
in highp vec2 texCoord2;
in highp vec2 texCoord3;
out highp vec4 fragColor;

void main() {
    highp vec4 sourceColor = (texture(source, texCoord0) + texture(source, texCoord1) +
                              texture(source, texCoord2) + texture(source, texCoord3)) / 4.0;
    fragColor = sourceColor * qt_Opacity;
}
