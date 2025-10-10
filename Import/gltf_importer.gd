extends Node

@export var import_button: Button
@export var load_dialog: FileDialog
@export var save_dialog: FileDialog

var main: Control

func _ready() -> void:
	import_button.pressed.connect(import_gltf)
	load_dialog.file_selected.connect(file_selected)
	get_window().files_dropped.connect(file_dropped)


func import_gltf() -> void:
	load_dialog.show()

func file_dropped(files: PackedStringArray) -> void:
	file_selected(files[0])


func file_selected(selected_file: String) -> void:
	if selected_file and FileAccess.file_exists(selected_file):
		
		if !selected_file.ends_with(".glb") and !selected_file.ends_with(".gltf"):
			Message.show_message(MessageContainer.message_type.error, "Invalid file type selected: " + selected_file.get_file())
			return
		
		var gltf_document_load = GLTFDocument.new()
		var gltf_state_load = GLTFState.new()
		var error = gltf_document_load.append_from_file(selected_file, gltf_state_load, 0, selected_file.get_base_dir())
		
		if error == OK:
			load_dialog.hide()
			main.set_imported_scene(gltf_document_load.generate_scene(gltf_state_load))
			
			
		else:
			Message.show_message(MessageContainer.message_type.error, "Couldn't load glTF scene (error code: %s)." % error_string(error))
	
	else:
		Message.show_message(MessageContainer.message_type.error, "Invalid file path:[br]" + (selected_file if selected_file.length() < 50 else ("..." + selected_file.right(47))))
