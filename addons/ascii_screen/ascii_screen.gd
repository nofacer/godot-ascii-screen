@icon("res://addons/ascii_screen/icon.svg")
class_name AsciiScreen
extends Node2D

@export var grid_size: Vector2i = Vector2i(10, 10)

@export_group("Charset")
@export var charset_texture: Texture2D
@export var char_size: Vector2i = Vector2i(8, 8)
@onready
var charset_texture_size := Vector2(charset_texture.get_width(), charset_texture.get_height())
@onready var charset_grid_size = Vector2(
	charset_texture_size.x / char_size.x, charset_texture_size.y / char_size.y
)
@onready var charset_total_num: int = charset_grid_size.x * charset_grid_size.y
@onready var screen_size: Vector2 = Vector2(grid_size.x * char_size.x, grid_size.y * char_size.y)

@export_group("Palette")
@export var palette_texture: Texture2D
@onready var palette_grid_size = Vector2(palette_texture.get_width(), palette_texture.get_height())
@onready var palette_total_num: int = palette_grid_size.x * palette_grid_size.y

@onready var render_shader: Shader = load("res://addons/ascii_screen/render.gdshader")
@onready var buffer: Image = self._init_buffer(grid_size)
@onready var render_texture: ImageTexture = ImageTexture.create_from_image(self.buffer)


func _ready() -> void:
	var material = ShaderMaterial.new()
	material.shader = render_shader
	material.set_shader_parameter("charset_texture", charset_texture)
	material.set_shader_parameter("grid_size", grid_size)
	material.set_shader_parameter("charset_grid_size", charset_grid_size)
	material.set_shader_parameter("palette_texture", palette_texture)
	material.set_shader_parameter("render_texture", render_texture)
	material.set_shader_parameter("palette_grid_size", palette_grid_size)

	var color_rect = ColorRect.new()
	color_rect.size = Vector2(grid_size.x * char_size.x, grid_size.y * char_size.y)
	color_rect.material = material
	add_child(color_rect)


func _init_buffer(size: Vector2i) -> Image:
	var buffer = Image.create_empty(size.x, size.y, false, Image.FORMAT_RGBA8)
	buffer.fill(Color(0, 0, 0, 1))
	return buffer


func put_char(x: int, y: int, char_idx: int, fg_idx: int = 0, bg_idx: int = 0):
	if x < 0 or x >= grid_size.x or y < 0 or y >= grid_size.y:
		return
	buffer.set_pixel(
		x,
		y,
		Color(
			float(char_idx) / float(charset_total_num - 1),
			float(fg_idx) / float(palette_total_num - 1),
			float(bg_idx) / float(palette_total_num - 1),
			1.0
		)
	)


func draw_letter(x: int, y: int, letter: String, fg_idx: int = 0, bg_idx: int = 0):
	if letter.length() != 1:
		return
	put_char(x, y, ord(letter), fg_idx, bg_idx)


func draw_word(from_x: int, from_y: int, word: String, fg_idx: int = 0, bg_idx: int = 0):
	for i in range(word.length()):
		put_char(from_x + i, from_y, ord(word[i]), fg_idx, bg_idx)


func draw_box(
	up_left_pos: Vector2i,
	down_right_pos: Vector2i,
	corner_chars: Array[int],
	edge_chars: Array[int],
	fg_idx: int = 0,
	bg_idx: int = 0
):
	put_char(up_left_pos.x, up_left_pos.y, corner_chars[0], fg_idx, bg_idx)
	put_char(down_right_pos.x, up_left_pos.y, corner_chars[1], fg_idx, bg_idx)
	put_char(down_right_pos.x, down_right_pos.y, corner_chars[2], fg_idx, bg_idx)
	put_char(up_left_pos.x, down_right_pos.y, corner_chars[3], fg_idx, bg_idx)

	for x in range(up_left_pos.x + 1, down_right_pos.x):
		put_char(x, up_left_pos.y, edge_chars[0], fg_idx, bg_idx)
		put_char(x, down_right_pos.y, edge_chars[0], fg_idx, bg_idx)
	for y in range(up_left_pos.y + 1, down_right_pos.y):
		put_char(up_left_pos.x, y, edge_chars[1], fg_idx, bg_idx)
		put_char(down_right_pos.x, y, edge_chars[1], fg_idx, bg_idx)


func flush():
	self.render_texture.update(buffer)
