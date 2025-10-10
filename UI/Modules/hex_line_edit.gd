class_name HexLineEdit
extends LineEdit

signal updated_color(color: Color)

@export var color_rect: ColorRect

func _ready() -> void:
	is_hex_color(text)
	text_changed.connect(is_hex_color)

func is_hex_color(hex_code: String) -> void:
	if hex_code.is_valid_html_color():
		var color: Color = Color.html(hex_code)
		updated_color.emit(color)
		color_rect.color = color
		color_rect.visible = visible
	else:
		color_rect.hide()
