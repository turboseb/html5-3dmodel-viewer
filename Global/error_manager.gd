extends Control

@export var popup_window: PackedScene

func show_error(error: String) -> void:
	var new_popup: PopupWindow = popup_window.instantiate()
	add_child(new_popup)
	new_popup.setup(PopupWindow.type_enum.error, error)
	new_popup.show()
