extends Node3D

var lights: Dictionary[Light3D, float] #Light: default power
@export var light_preview_scene: PackedScene
@export var sun: DirectionalLight3D


func add_light(light: Light3D) -> void:
	if light == sun:
		return
	light.set_shadow(true)
	var new_light_preview: Sprite3D = light_preview_scene.instantiate()
	add_child(new_light_preview)
	new_light_preview.setup(light)
	lights.get_or_add(light, light.light_energy)

func clear() -> void:
	for child: Sprite3D in get_children():
		child.queue_free()
	lights = {}


func set_sun(toggled_on: bool) -> void:
	visible = toggled_on

func set_power(value: float) -> void:
	for light: Light3D in lights.keys():
		light.light_energy = lights.get(light) * value


func set_sun_power(value: float) -> void:
	sun.light_energy = value

func set_sun_color(color: Color) -> void:
	sun.light_color = color
