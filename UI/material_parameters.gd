extends BoxContainer

@export var material_setter: Node

@export_group("Material")
@export var single_color_panel: Panel
@export var single_color_button: CheckButton
@export var color_edit: HexLineEdit
@export var single_color_material: StandardMaterial3D
@export var shaded_checkbox: CheckBox

func _ready() -> void:
	color_edit.updated_color.connect(set_single_color_hex)
	single_color_button.toggled.connect(set_single_color)
	shaded_checkbox.toggled.connect(set_shaded)
	

#region Material
func set_single_color(toggled_on: bool) -> void:
	if toggled_on:
		single_color_panel.show()
		material_setter.set_material_override(single_color_material)
	else:
		single_color_panel.hide()
		material_setter.remove_material_override()


func set_single_color_hex(color: Color) -> void:
	single_color_material.albedo_color = color


func set_shaded(toggled_on: bool) -> void:
	if toggled_on:
		single_color_material.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
	else:
		single_color_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED

#endregion

func update_scene() -> void:
	set_single_color(single_color_button.button_pressed)
