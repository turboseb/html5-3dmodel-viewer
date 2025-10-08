extends Control

@export var camera_pivot: Node3D
@export var split_container: SplitContainer
var interactable: bool = false
var scaling_window: bool = false

func _ready() -> void:
	mouse_entered.connect(set_interactable.bind(true))
	mouse_exited.connect(set_interactable.bind(false))
	
	split_container.drag_started.connect(set_scaling_window.bind(true))
	split_container.drag_ended.connect(set_scaling_window.bind(false))

func set_interactable(set_to: bool) -> void:
	interactable = set_to
	camera_pivot.interactable = interactable

func set_scaling_window(set_to: bool) -> void:
	scaling_window = set_to

func _input(event: InputEvent) -> void:
	if !camera_pivot.interactable or scaling_window:
		return
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("mouse_left"):
			
			var added_rotation := Vector3(-event.screen_relative.y * camera_pivot.sensitivity, -event.screen_relative.x * camera_pivot.sensitivity, 0)
			camera_pivot.rotate_camera(added_rotation)
