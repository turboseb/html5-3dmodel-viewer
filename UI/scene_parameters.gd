extends BoxContainer

@export var material_setter: Node

@export var single_color_panel: Panel
@export var single_color_button: CheckButton
@export var color_edit: LineEdit
@export var color_rect: ColorRect
@export var single_color_material: StandardMaterial3D

func _ready() -> void:
	color_edit.text_changed.connect(set_single_color_hex)
	single_color_button.toggled.connect(set_single_color)

func set_single_color(toggled_on: bool) -> void:
	if toggled_on:
		single_color_panel.show()
		material_setter.set_material_override(single_color_material)
	else:
		single_color_panel.hide()
		material_setter.remove_material_override()


func set_single_color_hex(hex_code: String) -> void:
	if hex_code.is_valid_html_color():
		single_color_material.albedo_color = Color.html(hex_code)
		color_rect.color = Color.html(hex_code)
		color_rect.visible = color_edit.visible
	else:
		color_rect.hide()
