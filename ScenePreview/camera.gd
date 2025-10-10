extends Node3D

@export var camera: Camera3D
@export var sensitivity: float = 0.01
@export var cam_speed: float = 1.0
var max_camera_distance: float = 100
var interactable: bool = false
@export var imported_scene_parent: Node3D

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


func rotate_camera(added_rotation: Vector3) -> void:
			rotation += added_rotation
			rotation.x = clamp(rotation.x, -PI * 0.5, PI * 0.5)


func reset_camera(bounds: AABB) -> float:
	var max_distances: Vector3 = bounds.size/2 + abs(bounds.position)
	var max_distance: float = max_distances.length()
	
	max_camera_distance = abs(max_distance/tan(rad_to_deg(camera.fov)/2))
	camera.position.z = max_camera_distance * 0.6
	print("new camera distance: ", str(abs(camera.position.z)))
	if imported_scene_parent.get_child_count() > 0:
		
		print(imported_scene_parent.get_child(0).get_meta_list())
	if max_camera_distance > 1000:
		Message.show_message(MessageContainer.message_type.warning, "3D Scene is very large, Could cause problems with ligthing/rendering")
	return max_camera_distance
