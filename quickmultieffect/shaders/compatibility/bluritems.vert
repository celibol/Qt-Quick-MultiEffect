attribute highp vec4 qt_Vertex;
attribute highp vec2 qt_MultiTexCoord0;
uniform highp mat4 qt_Matrix;
uniform highp vec2 step;
varying highp vec2 texCoord0;
varying highp vec2 texCoord1;
varying highp vec2 texCoord2;
varying highp vec2 texCoord3;

void main() {
    lowp float dither = 0.33;
    texCoord0 = vec2(qt_MultiTexCoord0.x + step.x, qt_MultiTexCoord0.y + step.y * dither);
    texCoord1 = vec2(qt_MultiTexCoord0.x + step.x * dither, qt_MultiTexCoord0.y - step.y);
    texCoord2 = vec2(qt_MultiTexCoord0.x - step.x * dither, qt_MultiTexCoord0.y + step.y);
    texCoord3 = vec2(qt_MultiTexCoord0.x - step.x, qt_MultiTexCoord0.y - step.y * dither);
    gl_Position = qt_Matrix * qt_Vertex;
}
