shader_type canvas_item;

uniform sampler2D render_texture;
uniform sampler2D charset_texture;
uniform sampler2D palette_texture;

uniform vec2 grid_size;
uniform vec2 charset_grid_size;
uniform vec2 palette_grid_size;

void fragment() {
  // Snap UV to grid center
  vec2 render_uv = (floor(UV * grid_size) + 0.5) / grid_size;
  vec4 render_data = texture(render_texture, render_uv);

  // Character + palette indices
  float total_chars = charset_grid_size.x * charset_grid_size.y;
  float total_colors = palette_grid_size.x * palette_grid_size.y;
  float char_idx = round(render_data.r * (total_chars - 1.0));
  float fg_idx = round(render_data.g * (total_colors - 1.0));
  float bg_idx = round(render_data.b * (total_colors - 1.0));

  // Charset atlas sampling
  float gx = mod(char_idx, charset_grid_size.x);
  float gy = floor(char_idx / charset_grid_size.x);
  vec2 local_uv = fract(UV * grid_size);
  vec2 atlas_uv = (vec2(gx, gy) + local_uv) / charset_grid_size;
  float mask = texture(charset_texture, atlas_uv).r;

  // Palette lookup (1D lookup using U coord)
  float fg_gx = mod(fg_idx, palette_grid_size.x);
  float fg_gy = floor(fg_idx / palette_grid_size.x);
  float bg_gx = mod(bg_idx, palette_grid_size.x);
  float bg_gy = floor(bg_idx / palette_grid_size.x);
  vec2 fg_uv = (vec2(fg_gx, fg_gy) + 0.5) / palette_grid_size;
  vec2 bg_uv = (vec2(bg_gx, bg_gy) + 0.5) / palette_grid_size;
  vec3 fg = texture(palette_texture, fg_uv).rgb;
  vec3 bg = texture(palette_texture, bg_uv).rgb;

  COLOR = vec4(mix(bg, fg, mask), 1.0);
}