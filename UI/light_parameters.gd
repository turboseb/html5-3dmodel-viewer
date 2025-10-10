extends FoldableContainer

@export var il_slider: ResetableSlider
@export var sun_button: CheckButton
@export var sun_slider: ResetableSlider
@export var sun_hex: HexLineEdit
@export var sun_panel: Panel
@export var light_setter: Node

func _ready() -> void:
	il_slider.value_changed.connect(light_setter.set_power)
	sun_button.toggled.connect(set_sun_parameters)
	sun_slider.value_changed.connect(light_setter.set_sun_power)
	sun_hex.updated_color.connect(light_setter.set_sun_color)

func set_sun_parameters(toggled_on: bool) -> void:
	light_setter.set_sun_power(toggled_on)
	sun_panel.visible = toggled_on
	sun_slider.visible = toggled_on

func update_scene() -> void:
	light_setter.set_power(il_slider.slider_value)
