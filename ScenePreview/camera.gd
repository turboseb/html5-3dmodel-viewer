extends Node3D

@export var subviewport: SubViewportContainer
@export var camera: Camera3D
@export var sensitivity: float = 0.01
@export var cam_speed: float = 1.0
var max_camera_distance: float = 100
var interactable: bool = false

func _ready() -> void:
	subviewport.mouse_entered.connect(set_interactable.bind(true))
	subviewport.mouse_exited.connect(set_interactable.bind(false))

func set_interactable(set_to: bool) -> void:
	interactable = set_to

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !interactable:
		return
	if Input.is_action_just_pressed("scroll_down"):
		camera.position.z += delta * cam_speed * sqrt(camera.position.z)
		clamp_camera()
	elif Input.is_action_just_pressed("scroll_up"):
		camera.position.z -= delta * cam_speed * sqrt(camera.position.z)
		clamp_camera()

func clamp_camera() -> void:
	camera.position.z = clamp(camera.position.z, 0.01, max_camera_distance)

func _input(event: InputEvent) -> void:
	if !interactable:
		return
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("mouse_left"):
			rotation.x -= event.screen_relative.y * sensitivity
			rotation.y -= event.screen_relative.x * sensitivity
			
			rotation.x = clamp(rotation.x, -PI, PI)

func reset_camera(bounds: AABB) -> void:
	var max_distances: Vector3 = bounds.size/2 + abs(bounds.position)
	var max_distance: float = max_distances.length()
	
	max_camera_distance = abs(max_distance/tan(rad_to_deg(camera.fov)/2))
	camera.position.z = max_camera_distance * 0.6
	print("new camera distance: ", str(abs(camera.position.z)))
