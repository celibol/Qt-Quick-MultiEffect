#version 330 core
in highp vec4 qt_Vertex;
in highp vec2 qt_MultiTexCoord0;
uniform highp mat4 qt_Matrix;
uniform highp vec2 step;
out highp vec2 texCoord0;
out highp vec2 texCoord1;
out highp vec2 texCoord2;
out highp vec2 texCoord3;

void main() {
    lowp float dither = 0.33;
    texCoord0 = vec2(qt_MultiTexCoord0.x + step.x, qt_MultiTexCoord0.y + step.y * dither);
    texCoord1 = vec2(qt_MultiTexCoord0.x + step.x * dither, qt_MultiTexCoord0.y - step.y);
    texCoord2 = vec2(qt_MultiTexCoord0.x - step.x * dither, qt_MultiTexCoord0.y + step.y);
    texCoord3 = vec2(qt_MultiTexCoord0.x - step.x, qt_MultiTexCoord0.y - step.y * dither);
    gl_Position = qt_Matrix * qt_Vertex;
}
