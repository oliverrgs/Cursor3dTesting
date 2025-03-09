shader_type spatial;

uniform vec4 water_color : source_color = vec4(0.0, 0.4, 0.6, 0.8);
uniform vec4 deep_water_color : source_color = vec4(0.0, 0.1, 0.4, 0.8);
uniform float wave_speed = 0.5;
uniform float wave_strength = 0.2;
uniform sampler2D noise_texture;
uniform sampler2D normal_texture;
uniform float roughness : hint_range(0.0, 1.0) = 0.1;
uniform float metallic : hint_range(0.0, 1.0) = 0.8;
uniform float specular : hint_range(0.0, 1.0) = 0.5;
uniform float fresnel : hint_range(0.0, 1.0) = 0.8;

varying vec3 vertex_pos;
varying vec2 tex_uv;

void vertex() {
    vertex_pos = VERTEX;
    tex_uv = UV;
    
    // Animate waves
    float time = TIME * wave_speed;
    vec2 uv1 = UV + time * 0.1;
    vec2 uv2 = UV - time * 0.1;
    float noise1 = texture(noise_texture, uv1).r;
    float noise2 = texture(noise_texture, uv2).r;
    
    // Apply wave displacement
    VERTEX.y += (noise1 - 0.5) * wave_strength;
    VERTEX.y += (noise2 - 0.5) * wave_strength * 0.5;
    
    // Calculate normal based on wave height
    NORMAL = normalize(vec3(noise1 - noise2, 1.0, noise2 - noise1));
}

void fragment() {
    // Sample normal map for detail
    vec2 uv_speed = vec2(TIME * 0.1, TIME * 0.1);
    vec3 normal1 = texture(normal_texture, tex_uv + uv_speed).rgb * 2.0 - 1.0;
    vec3 normal2 = texture(normal_texture, tex_uv * 2.0 - uv_speed).rgb * 2.0 - 1.0;
    
    // Blend normals
    NORMAL_MAP = normalize(normal1 + normal2);
    
    // Calculate depth fade
    float depth = texture(DEPTH_TEXTURE, SCREEN_UV).r;
    vec3 ndc = vec3(SCREEN_UV * 2.0 - 1.0, depth);
    vec4 view = INV_PROJECTION_MATRIX * vec4(ndc, 1.0);
    view.xyz /= view.w;
    float depth_fade = clamp(1.0 - (-view.z * 0.1), 0.0, 1.0);
    
    // Mix colors based on depth
    vec4 color = mix(water_color, deep_water_color, depth_fade);
    
    // Apply fresnel effect
    float fresnel_effect = pow(1.0 - dot(normalize(VIEW), NORMAL_MAP), fresnel);
    color.rgb = mix(color.rgb, vec3(1.0), fresnel_effect * 0.5);
    
    // Set material properties
    ALBEDO = color.rgb;
    ALPHA = color.a;
    METALLIC = metallic;
    ROUGHNESS = roughness;
    SPECULAR = specular;
} 