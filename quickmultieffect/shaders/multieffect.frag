#version 440

layout(location = 0) in vec2 texCoord;
layout(location = 1) in vec2 shadowTexCoord;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;

    float shadowScale;
    vec2 shadowOffset;
    vec2 centerOffset;

    float contrast;
    float brightness;
    float saturation;
    vec4 colorizeColor;
    vec4 blurWeight1;
    vec2 blurWeight2;
    vec4 mask;
    float maskInverted;
    vec4 shadowColor;
    vec4 shadowBlurWeight1;
    vec2 shadowBlurWeight2;
};

#if defined(BLUR) || defined(SHADOW)
#if defined(BL1)
layout(binding = 1) uniform sampler2D blurSrc1;
layout(binding = 2) uniform sampler2D blurSrc2;
#endif
#if defined(BL2)
layout(binding = 3) uniform sampler2D blurSrc3;
#endif
#if defined(BL3)
layout(binding = 4) uniform sampler2D blurSrc4;
#endif
#if defined(BL4)
layout(binding = 5) uniform sampler2D blurSrc5;
#endif
#if defined(BL5)
layout(binding = 6) uniform sampler2D blurSrc6;
#endif
#endif // BLUR || SHADOW

// This is a bit complicated to make sure
// these have correct binding values
#if defined(BL5)
layout(binding = 7) uniform sampler2D src;
#if defined(MASK)
layout(binding = 8) uniform sampler2D maskSrc;
#endif
#elif defined(BL4)
layout(binding = 6) uniform sampler2D src;
#if defined(MASK)
layout(binding = 7) uniform sampler2D maskSrc;
#endif
#elif defined(BL3)
layout(binding = 5) uniform sampler2D src;
#if defined(MASK)
layout(binding = 6) uniform sampler2D maskSrc;
#endif
#elif defined(BL2)
layout(binding = 4) uniform sampler2D src;
#if defined(MASK)
layout(binding = 5) uniform sampler2D maskSrc;
#endif
#elif defined(BL1)
layout(binding = 3) uniform sampler2D src;
#if defined(MASK)
layout(binding = 4) uniform sampler2D maskSrc;
#endif
#else // BL0 or no blur or shadow
layout(binding = 1) uniform sampler2D src;
#if defined(MASK)
layout(binding = 2) uniform sampler2D maskSrc;
#endif

#endif

void main() {

#if !defined(BLUR)
    vec4 color = texture(src, texCoord);
#else // BLUR
    vec4 color = texture(blurSrc1, texCoord) * blurWeight1[0];
    color += texture(blurSrc2, texCoord) * blurWeight1[1];
#if defined(BL2)
    color += texture(blurSrc3, texCoord) * blurWeight1[2];
#endif
#if defined(BL3)
    color += texture(blurSrc4, texCoord) * blurWeight1[3];
#endif
#if defined(BL4)
    color += texture(blurSrc5, texCoord) * blurWeight2[0];
#endif
#if defined(BL5)
    color += texture(blurSrc6, texCoord) * blurWeight2[1];
#endif
#endif // BLUR

    color.rgb = (color.rgb - 0.5 * color.a) * (1.0 + contrast) + 0.5 * color.a;
    color.rgb += brightness * color.a;
    float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));
    color.rgb = gray * colorizeColor.rgb * colorizeColor.a + color.rgb * (1.0 - colorizeColor.a);
    color.rgb = mix(vec3(gray), color.rgb, 1.0 + saturation);

#if defined(SHADOW)
    float shadow = 0.0;
#if defined(BL0)
    shadow = texture(src, shadowTexCoord).a;
#endif
#if defined(BL1)
    shadow = texture(blurSrc1, shadowTexCoord).a * shadowBlurWeight1[0];
    shadow += texture(blurSrc2, shadowTexCoord).a * shadowBlurWeight1[1];
#endif
#if defined(BL2)
    shadow += texture(blurSrc3, shadowTexCoord).a * shadowBlurWeight1[2];
#endif
#if defined(BL3)
    shadow += texture(blurSrc4, shadowTexCoord).a * shadowBlurWeight1[3];
#endif
#if defined(BL4)
    shadow += texture(blurSrc5, shadowTexCoord).a * shadowBlurWeight2[0];
#endif
#if defined(BL5)
    shadow += texture(blurSrc6, shadowTexCoord).a * shadowBlurWeight2[1];
#endif
    shadow *= shadowColor.a;
    float aa = (1.0 - color.a) * (1.0 - shadow);
    color.rgb = mix(shadowColor.rgb * shadow, color.rgb, color.a + aa);
    color.a = 1.0 - aa;
#endif // SHADOW

#if defined(MASK)
    float alphaMask = texture(maskSrc, texCoord).a;
    float m1 = smoothstep(mask[0] * mask[1] - (mask[1] - 0.999), mask[0] * mask[1], alphaMask);
    float m2 = smoothstep((1.0 - mask[2]) * mask[3] - (mask[3] - 0.999), (1.0 - mask[2]) * mask[3], (1.0 - alphaMask));
    float mm = m1 * m2;
    color *= (1.0 - maskInverted) * mm + maskInverted * (1.0 - mm);
#endif // MASK

    fragColor = color * qt_Opacity;
}