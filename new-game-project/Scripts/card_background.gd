extends Sprite2D

@onready var shader_material := material as ShaderMaterial  # Rename to avoid conflict

enum Race { HUMAN, GOBLIN, OBJECT, ANIMAL, ARCANIAN, UNDEAD }  # Updated race order

var race_palettes = {
	Race.HUMAN: [
		Color("fff400"), Color("edce86"), Color("f9d686"),
		Color("ffdb89"), Color("f9de9f"),
	],
	Race.GOBLIN: [
		Color("00ff00"), Color("66a64b"), Color("8fc866"),
		Color("a5de86"), Color("c0f5a6"),
	],
	Race.OBJECT: [
		Color("ec0000"), Color("a03030"), Color("b83030"),
		Color("d03030"), Color("e83030")
	],
	Race.ANIMAL: [
		Color("8b4513"), Color("a0522d"), Color("cd853f"),
		Color("deb887"), Color("f5deb3")
	],
	Race.ARCANIAN: [
		Color("a800ff"), Color("6a0dad"), Color("a42cd6"),
		Color("ba55d3"), Color("dda0dd")
	],
	Race.UNDEAD: [
		Color("708090"), Color("778899"), Color("a9a9a9"),
		Color("c0c0c0"), Color("d3d3d3")
	]
}

func apply_race_palette(race):
	var colors = race_palettes.get(race, race_palettes[Race.HUMAN])  # Default to HUMAN colors if race not found
	
	shader_material.set_shader_parameter("find_color1", Color("fff400"))
	shader_material.set_shader_parameter("target_color1", colors[0])
	shader_material.set_shader_parameter("find_color2", Color("f9de9f"))
	shader_material.set_shader_parameter("target_color2", colors[1])
	shader_material.set_shader_parameter("find_color3", Color("ffdb89"))
	shader_material.set_shader_parameter("target_color3", colors[2])
	shader_material.set_shader_parameter("find_color4", Color("f9d686"))
	shader_material.set_shader_parameter("target_color4", colors[3])
	shader_material.set_shader_parameter("find_color5", Color("edce86"))
	shader_material.set_shader_parameter("target_color5", colors[4])
