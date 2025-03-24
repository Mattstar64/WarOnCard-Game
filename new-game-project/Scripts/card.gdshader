shader_type canvas_item;

uniform vec4 find_color1 : source_color;
uniform vec4 target_color1 : source_color;
uniform vec4 find_color2 : source_color;
uniform vec4 target_color2 : source_color;
uniform vec4 find_color3 : source_color;
uniform vec4 target_color3 : source_color;
uniform vec4 find_color4 : source_color;
uniform vec4 target_color4 : source_color;
uniform vec4 find_color5 : source_color;
uniform vec4 target_color5 : source_color;

void fragment() {
    vec4 pixel_color = texture(TEXTURE, UV);

    // Replace up to 5 different colors
    if (length(pixel_color.rgb - find_color1.rgb) < 0.01) {
        COLOR = target_color1;
    } else if (length(pixel_color.rgb - find_color2.rgb) < 0.01) {
        COLOR = target_color2;
    } else if (length(pixel_color.rgb - find_color3.rgb) < 0.01) {
        COLOR = target_color3;
    } else if (length(pixel_color.rgb - find_color4.rgb) < 0.01) {
        COLOR = target_color4;
    } else if (length(pixel_color.rgb - find_color5.rgb) < 0.01) {
        COLOR = target_color5;
    } else {
        COLOR = pixel_color;  // Keep the original color if no match
    }
}
