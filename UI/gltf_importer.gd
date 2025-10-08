extends Node


@export var temporary_dir: String
@export var file_name: String
@export var exported_scene: Node3D
@export var import_button: Button
@export var save_button: Button
@export var load_dialog: FileDialog
@export var save_dialog: FileDialog
@export var scene_preview: Node3D
@export var camera_pivot: Node3D

var gltf_scene_root_node: Node3D

func _ready() -> void:
	import_button.pressed.connect(import_gltf)
	save_button.pressed.connect(save_scene)
	load_dialog.file_selected.connect(file_selected)
	get_window().files_dropped.connect(file_dropped)
	save_dialog.file_selected.connect(export_scene)
	remove_temporary_files()

func import_gltf() -> void:
	load_dialog.hide()
	load_dialog.ok_button_text = "Import"
	load_dialog.show()

func file_dropped(files: PackedStringArray) -> void:
	file_selected(files[0])


func file_selected(selected_file: String) -> void:
	if selected_file and FileAccess.file_exists(selected_file):
		if !selected_file.ends_with(".glb") and !selected_file.ends_with(".gltf"):
			print("Invalid file type selected")
			ErrorManager.show_error("Invalid file type selected:[br]" + selected_file)
			return
		var gltf_document_load = GLTFDocument.new()
		var gltf_state_load = GLTFState.new()
		var error = gltf_document_load.append_from_file(selected_file, gltf_state_load)
		if error == OK:
			print("file imported")
			load_dialog.hide()
			gltf_scene_root_node = gltf_document_load.generate_scene(gltf_state_load)
			scene_preview.new_imported_scene(gltf_scene_root_node)
			
		else:
			ErrorManager.show_error("Couldn't load glTF scene (error code: %s)." % error_string(error))
	else:
		printerr("invalid filename: ", selected_file)

func save_scene() -> void:
	if gltf_scene_root_node != null:
		save_dialog.show()
	else:
		ErrorManager.show_error("No 3D scene imported")

func export_scene(selected_file: String) -> void:
		if selected_file and selected_file.is_absolute_path():
			#selected_file = selected_file.left(-3)
			if selected_file.ends_with("."):
				selected_file = selected_file.left(-1)
			if !selected_file.ends_with(".zip"):
				selected_file += ".zip"
			var scene = PackedScene.new()
			scene.pack(exported_scene)
			var scene_error: Error = ResourceSaver.save(scene, "res://" + file_name + ".tscn")
			print("packedscene save: ", scene_error)
			if !FileAccess.file_exists("res://" + file_name + ".tscn"):
				printerr("Packedscene not saved under ", "res://" + file_name + ".tscn")
			var packer = PCKPacker.new()
			var start_error: Error = packer.pck_start("res://" + file_name + ".pck")
			if start_error != OK:
				printerr("PCKPacker.pck_start: ", start_error)
			var add_file_error: Error = packer.add_file("res://" + file_name + ".tscn", file_name + ".tscn")
			if add_file_error != OK:
				printerr("PCKPacker.add_file: ", error_string(add_file_error))
			var flush_error: Error = packer.flush()
			if flush_error != OK:
				printerr("PCKPacker.flush: ", flush_error)
			var zip_error: Error = write_zip_file(selected_file)
			if zip_error == OK:
				return
			else:
				ErrorManager.show_error("Invalid Zip File Path")
		else:
			ErrorManager.show_error("Invalid File Path")


func write_zip_file(selected_file: String) -> Error:
	print("selected_file: ", selected_file)
	DirAccess.copy_absolute("res://blank_viewer.zip",selected_file)
	var writer = ZIPPacker.new()
	var err = writer.open(selected_file, ZIPPacker.APPEND_ADDINZIP)
	if err != OK:
		return err
	writer.start_file("blank_viewer/" + file_name + ".pck")
	writer.write_file(FileAccess.get_file_as_bytes("res://" + file_name + ".pck"))
	writer.close_file()
	writer.close()
	remove_temporary_files()
	
	return OK


func remove_temporary_files() -> void:
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	#if !DirAccess.dir_exists_absolute(temporary_dir):
		#return
	if OS.has_feature("editor"):
		print("saving at res")
		if FileAccess.file_exists("res://" + file_name + ".tscn"):
			DirAccess.remove_absolute("res://" + file_name + ".tscn")
		if FileAccess.file_exists("res://" + file_name + ".pck"):
			DirAccess.remove_absolute("res://" + file_name + ".pck")
		
	else:
		var base_dir: String = OS.get_executable_path().get_base_dir()
		print(base_dir)
		if FileAccess.file_exists(base_dir + "/" + file_name + ".tscn"):
			DirAccess.remove_absolute(base_dir + "/" + file_name + ".tscn")
		else:
			printerr("scene not found")
		if FileAccess.file_exists(base_dir + "/" + file_name + ".pck"):
			DirAccess.remove_absolute(base_dir + "/" + file_name + ".pck")
		else:
			printerr("package not found")
		
		
		
	
	
