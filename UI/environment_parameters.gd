extends FoldableContainer

@export var amb_slider: ResetableSlider
@export var amb_hex: HexLineEdit
@export var bg_hex: HexLineEdit
@export var environment: Environment

func _ready() -> void:
	amb_slider.value_changed.connect(set_ambient_power)
	amb_hex.updated_color.connect(set_ambient_color)
	bg_hex.updated_color.connect(set_background_color)
	

func set_ambient_power(value: float) -> void:
	environment.ambient_light_energy = value

func set_ambient_color(color: Color) -> void:
	environment.ambient_light_color = color

func set_background_color(color: Color) -> void:
	environment.background_color = color

func update_scene() -> void:
	pass
