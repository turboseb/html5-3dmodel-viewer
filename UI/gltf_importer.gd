extends Control

@export var import_button: Button
@export var save_button: Button
@export var file_dialog: FileDialog
@export var scene_preview: Node3D

var gltf_scene_root_node: Node3D

func _ready() -> void:
	import_button.pressed.connect(import_gltf)
	save_button.pressed.connect(save_scene)
	file_dialog.file_selected.connect(file_selected)

func import_gltf() -> void:
	file_dialog.hide()
	file_dialog.ok_button_text = "Import"
	file_dialog.show()
	

func file_selected(selected_file: String) -> void:
	print("ok")
	if selected_file and selected_file.is_absolute_path():
		if !selected_file.ends_with(".glb") and !selected_file.ends_with(".gltf"):
			print("Invalid file type selected")
			ErrorManager.show_error("Invalid file type selected:[br]" + selected_file)
			return
		var gltf_document_load = GLTFDocument.new()
		var gltf_state_load = GLTFState.new()
		var error = gltf_document_load.append_from_file(selected_file, gltf_state_load)
		if error == OK:
			print("file imported")
			for child in scene_preview.get_children():
				child.queue_free()
			file_dialog.hide()
			gltf_scene_root_node = gltf_document_load.generate_scene(gltf_state_load)
			scene_preview.add_child(gltf_scene_root_node)
			SignalBus.scene_imported.emit()
		else:
			ErrorManager.show_error("Couldn't load glTF scene (error code: %s)." % error_string(error))
	else:
		printerr("invalid filename: ", selected_file)

func save_scene() -> void:
	if gltf_scene_root_node != null:
		var scene = PackedScene.new()
		scene.pack(gltf_scene_root_node)
		ResourceSaver.save(scene, "res://file/test.tscn")
		var packer = PCKPacker.new()
		packer.pck_start("res://file/test.pck")
		packer.add_file("res://file/test.tscn", "test.tscn")
		packer.flush()
		
