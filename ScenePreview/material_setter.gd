extends Node

@export var scene_parent: Node3D

func set_material_override(material: Material, parent_node: Node = scene_parent) -> void:
	for child: Node in parent_node.get_children():
		if child is GeometryInstance3D:
			child.material_override = material
		if child.get_child_count() > 0:
			set_material_override(material, child)

func remove_material_override(parent_node: Node = scene_parent) -> void:
	for child: Node in parent_node.get_children():
		if child is GeometryInstance3D:
			child.material_override = null
		if child.get_child_count() > 0:
			remove_material_override(child)
