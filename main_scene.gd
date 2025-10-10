extends Control

var gltf_scene_root_node: Node3D
@export var gltf_importer: Node
@export var package_exporter: Node
@export var scene_preview: Node3D
@export var scene_parameters: Control

func _ready() -> void:
	gltf_importer.main = self
	package_exporter.main = self


func set_imported_scene(new_scene_root_node: Node3D) -> void:
	gltf_scene_root_node = new_scene_root_node
	await scene_preview.new_imported_scene(gltf_scene_root_node)
	scene_parameters.update_scene()
