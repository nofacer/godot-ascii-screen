extends Node2D

@onready var ascii_screen: AsciiScreen = $AsciiScreen


func _ready() -> void:
	ascii_screen.draw_box(
		Vector2i(0, 0),
		Vector2i(15, 15),
		[
			CP437.Char.BOX_DRAWINGS_LIGHT_DOWN_AND_RIGHT,
			CP437.Char.BOX_DRAWINGS_LIGHT_DOWN_AND_LEFT,
			CP437.Char.BOX_DRAWINGS_LIGHT_UP_AND_LEFT,
			CP437.Char.BOX_DRAWINGS_LIGHT_UP_AND_RIGHT
		],
		[CP437.Char.BOX_DRAWINGS_LIGHT_HORIZONTAL, CP437.Char.BOX_DRAWINGS_LIGHT_VERTICAL],
		Palette.Colors.LIGHT_GOLD,
		Palette.Colors.BLACK
	)

	ascii_screen.draw_word(1, 0, "Woods:", Palette.Colors.LIGHT_GOLD, Palette.Colors.BLACK)
	ascii_screen.draw_word(7, 0, "f2", Palette.Colors.IVORY, Palette.Colors.BLACK)
	ascii_screen.put_char(
		11, 0, CP437.Char.CENT_SIGN, Palette.Colors.LIGHT_GOLD, Palette.Colors.BLACK
	)
	ascii_screen.draw_letter(12, 0, "0", Palette.Colors.ASH_GRAY, Palette.Colors.BLACK)
	ascii_screen.draw_word(13, 0, "25", Palette.Colors.ORANGE, Palette.Colors.BLACK)
	ascii_screen.flush()
