# Godot ASCII Screen Plugin

## Overview

The Godot ASCII Screen plugin provides a framework for rendering ASCII graphics in the Godot Engine. It is designed for retro-style games, roguelikes, and any project that benefits from character-based rendering. The plugin supports code page 437, custom palettes, and flexible rendering via shaders.

## Features

- ASCII screen rendering using code page 437
- Customizable color palettes
- Shader-based rendering for performance and flexibility
- Example scenes and assets for quick start
- Easy integration into existing Godot projects

## Directory Structure

- `addons/ascii_screen/` — Main plugin code
  - `ascii_screen.gd` — Core ASCII screen logic
  - `code_page_437_enum.gd` — Code page 437 character definitions
  - `render.gdshader` — Shader for ASCII rendering
  - `plugin.gd`, `plugin.cfg` — Godot plugin configuration
  - `icon.svg` — Plugin icon
- `example/` — Example project and assets
  - `main.gd`, `main.tscn` — Example scene and script
  - `dungeon-437.png`, `dungeon-pal.png` — Example tileset and palette
  - `palette.gd` — Palette logic

## Getting Started

1. Copy the `addons/ascii_screen` folder into your Godot project's `addons` directory.
2. Enable the plugin in the Godot Editor (`Project > Project Settings > Plugins`).
3. Review the example in the `example/` folder for usage patterns.
4. Create an ASCII screen node in your scene and configure its properties as needed.

## Usage Example

```gdscript
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
  ascii_screen.put_char(11, 0, CP437.Char.CENT_SIGN, Palette.Colors.LIGHT_GOLD, Palette.Colors.BLACK)
  ascii_screen.draw_letter(12, 0, "0", Palette.Colors.ASH_GRAY, Palette.Colors.BLACK)
  ascii_screen.draw_word(13, 0, "25", Palette.Colors.ORANGE, Palette.Colors.BLACK)
  ascii_screen.flush()
```

## License

MIT License. See LICENSE file for details.

## Credits

Example image assets sourced from [DungeonMode by datagoblin](https://datagoblin.itch.io/dungeonmode).

---

For more information, see the plugin source code and example project.
