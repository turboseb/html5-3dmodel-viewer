extends Node

@export var file_name: String
@export var export_button: Button
@export var export_dialog: FileDialog
@export var exported_scene: Node3D

var main: Control

func _ready() -> void:
	export_button.pressed.connect(get_export_directory)
	export_dialog.file_selected.connect(export_scene)

func get_export_directory() -> void:
	if main.gltf_scene_root_node != null:
		export_dialog.show()
	else:
		Message.show_message(MessageContainer.message_type.warning, "No 3D scene imported")


func export_scene(selected_file: String) -> void:
		if selected_file.ends_with("."):
			selected_file = selected_file.left(-1)
		if !selected_file.ends_with(".zip"):
			selected_file += ".zip"
		if selected_file and selected_file.is_absolute_path() and DirAccess.dir_exists_absolute(selected_file.get_base_dir()):
			var scene = PackedScene.new()
			var pack_error: Error = scene.pack(exported_scene)
			if pack_error != OK:
				Message.show_message(MessageContainer.message_type.error, "Couldn't pack the node branch into a PackedScene (error code: %s)." % error_string(pack_error))
				return
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
			
			write_zip_file(selected_file)
		
		else:
			Message.show_message(MessageContainer.message_type.error, "Invalid file path:[br]" + (selected_file if selected_file.length() < 50 else ("..." + selected_file.right(47))))


func write_zip_file(selected_file: String) -> void:
	print("selected_file: ", selected_file)
	
	var copy_error: Error = DirAccess.copy_absolute("res://blank_viewer.zip",selected_file)
	if copy_error != OK:
		Message.show_message(MessageContainer.message_type.error, "Couldn't copy blank_viewer.zip to path (error code: %s)." % error_string(copy_error))
		return
	
	var writer = ZIPPacker.new()
	var open_error: Error = writer.open(selected_file, ZIPPacker.APPEND_ADDINZIP)
	if open_error != OK:
		Message.show_message(MessageContainer.message_type.error, "Couldn't export zip file (error code: %s)." % error_string(open_error))
		return
		
	var start_error: Error = writer.start_file("blank_viewer/" + file_name + ".pck")
	if start_error != OK:
		Message.show_message(MessageContainer.message_type.error, "Couldn't start writing to file (error code: %s)." % error_string(start_error))
		return
	
	var write_error: Error = writer.write_file(FileAccess.get_file_as_bytes("res://" + file_name + ".pck"))
	if write_error != OK:
		Message.show_message(MessageContainer.message_type.error, "Couldn't write packed scene to file (error code: %s)." % error_string(write_error))
		return
	
	var close_file_error: Error = writer.close_file()
	if close_file_error != OK:
		Message.show_message(MessageContainer.message_type.error, "Couldn't close zip file (error code: %s)." % error_string(close_file_error))
		return
	
	var close_error: Error = writer.close()
	if close_error != OK:
		Message.show_message(MessageContainer.message_type.error, "Couldn't close ZIPPacker (error code: %s)." % error_string(close_error))
		return
	
	Message.show_message(MessageContainer.message_type.success, "Scene Packaged and exported to " + selected_file.get_file())
	remove_temporary_files()
	


func remove_temporary_files() -> void:
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
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
			Message.show_message(MessageContainer.message_type.warning, 'Temporary file "%s.tscn" not removed' % [file_name])
		
		if FileAccess.file_exists(base_dir + "/" + file_name + ".pck"):
			DirAccess.remove_absolute(base_dir + "/" + file_name + ".pck")
		else:
			Message.show_message(MessageContainer.message_type.warning, 'Temporary file "%s.pck" not removed' % [file_name])
