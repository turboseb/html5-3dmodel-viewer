class_name MessageContainer
extends MarginContainer

enum message_type {success, warning, error}

@export_group("internal")
@export var message_icons: Dictionary[message_type, Texture2D]
@export var label: RichTextLabel
@export var margin_node: Control
@export var container: PanelContainer
@export var kill_timer: Timer

func _ready() -> void:
	pass
	kill_timer.timeout.connect(kill_message)

func setup(type: message_type, message: String) -> void:
	var message_text: String = "[img=20]%s[/img] " % [message_icons.get(type).resource_path]
	message_text += message
	label.text = message_text
	await get_tree().process_frame
	margin_node.custom_minimum_size.y = container.size.y
	
	container.position.x = 10
	#margin_node.set_anchors_preset(Control.PRESET_TOP_RIGHT)
	#set_h_size_flags(Control.SIZE_SHRINK_END)
	#set_v_size_flags(Control.SIZE_SHRINK_BEGIN)
	#container.set_anchors_preset(Control.PRESET_TOP_RIGHT)
	animate_entry()

var tween: Tween
func animate_entry() -> void:
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween.tween_property(container, "position:x", - container.size.x - 4.0, 0.8)
	await tween.finished


func kill_message() -> void:
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween().set_parallel(true)
	##FIXME
	tween.tween_property(container, "modulate:a", 0.0, 1.0)
	await tween.finished
	queue_free()
