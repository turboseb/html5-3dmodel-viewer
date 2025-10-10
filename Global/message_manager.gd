extends Control

@export var message_scene: PackedScene
@export var message_list: BoxContainer

func show_message(type: MessageContainer.message_type, message: String) -> void:
	var new_message: MessageContainer = message_scene.instantiate()
	message_list.add_child(new_message)
	new_message.setup(type, message)
