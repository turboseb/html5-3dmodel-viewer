class_name PopupWindow
extends Window

enum type_enum {warning, error}

@export var label: RichTextLabel

func _ready() -> void:
	close_requested.connect(close_window)

func close_window() -> void:
	queue_free()

func setup(type:type_enum, message: String) -> void:
	match type:
		type_enum.warning:
			pass
		type_enum.error:
			title = "Error"
			label.text = "[b]" +message
