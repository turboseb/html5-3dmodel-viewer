@tool
class_name ResetableSlider
extends BoxContainer

@export var slider_name: String:
	set(value):
		slider_name = value
		label.text = value
		label.visible = (value != "")
		spacer.visible = label.visible

@export var max_value: float = 2.0
@export var min_value: float = 0.0
@export var slider_value: float = 1.0:
	set(value):
		slider_value = value
		if delay_timer.is_stopped():
			delay_timer.start()


@export_group("internal")
@export var slider: Slider
@export var reset_button: Button
@export var label: Label
@export var delay_timer: Timer
@export var spacer: Control

signal value_changed(value: float)

var default_slider_value: float


func _ready() -> void:
	if Engine.is_editor_hint():
		return
	if slider_name == "":
		spacer.hide()
	reset_button.disabled = true
	setup_slider()
	default_slider_value = slider_value
	reset_button.pressed.connect(reset_slider)
	slider.value_changed.connect(slider_update)
	delay_timer.timeout.connect(emit_new_value)


func setup_slider() -> void:
	slider.max_value = max_value
	slider.min_value = min_value
	slider.value = slider_value

func reset_slider() -> void:
	slider.value = default_slider_value

func slider_update(value: float) -> void:
	slider_value = value
	reset_button.disabled = (value == default_slider_value)

func emit_new_value() -> void:
	value_changed.emit(slider_value)
