extends Sprite3D

@export var light_icons: Dictionary[String, Texture2D]

var light: Light3D
var type: String

func setup(light_node: Light3D) -> void:
	light = light_node
	global_position = light.global_position
	type = light.get_class()
	texture = light_icons.get(type)
