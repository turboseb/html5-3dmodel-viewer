extends Node3D

@export var camera: Node3D
@export var import_parent: Node3D
@export var exported_scene: Node3D
@export var light_preview: Node3D

func _ready() -> void:
	get_node_aabb(exported_scene)

func set_ownership(node: Node) -> void:
	node.owner = exported_scene


func new_imported_scene(gltf_scene_root_node: Node) -> Error:
	light_preview.clear()
	for child: Node in import_parent.get_children():
		child.queue_free()
	import_parent.add_child(gltf_scene_root_node)
	exported_scene.set_meta("max_camera_ditance", reset_camera())
	return OK

func reset_camera() -> float:
	return camera.reset_camera(get_node_aabb(import_parent))


## Return the [AABB] of the node.
## From u/Magodra on reddit [https://www.reddit.com/r/godot/comments/18bfn0n/comment/mcvw7cl/]
func get_node_aabb(node : Node, exclude_top_level_transform: bool = true) -> AABB:
	var bounds : AABB = AABB()
	
	# Do not include children that is queued for deletion
	if node.is_queued_for_deletion():
		return bounds
	

	if node is Light3D:
		light_preview.add_light(node)
	

	# Get the aabb of the Geometry instance
	elif node is GeometryInstance3D:
		bounds = node.get_aabb();
	
	# Recurse through all children
	for child in node.get_children():
		set_ownership(child)
		var child_bounds : AABB = get_node_aabb(child, false)
		if bounds.size == Vector3.ZERO:
			bounds = child_bounds
		else:
			bounds = bounds.merge(child_bounds)
	
	if !exclude_top_level_transform and bounds != AABB():
		bounds = node.transform * bounds
	
	return bounds
