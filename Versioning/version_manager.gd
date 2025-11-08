@tool
extends Node

@export var version: Vector3i = Vector3i(1, 0, 0):
	set(value):
		if version == value:
			return
		version = value
		if Engine.is_editor_hint():
			update_version()
		
@export var version_changelog: String:
	set(value):
		if Engine.is_editor_hint():
			version_changelog = value
			if version_changelog_link:
				version_changelog_link.uri = value

@export_group("internal")
@export var version_changelog_link: LinkButton
@export var requester: HTTPRequest
@export var update_available_link: LinkButton

var latest_version: Vector3i
var api_url: String = "https://itch.io/api/1/x/wharf/latest?target=turboseb/3d-scene-viewer&channel_name=windows"

func update_version() -> void:
	if version_changelog_link:
		version_changelog_link.text = "version" + get_version_string(version)

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	get_latest_version()

func get_latest_version() -> void:
	requester.request_completed.connect(_on_request_completed)
	var error: Error = requester.request(api_url)
	if error != OK:
		printerr("Error initiating http request: ", error_string(error), ", , cannot check for updates")

func _on_request_completed(result: int, _response_code: int, _headers: PackedStringArray, body: PackedByteArray) -> void:
	if result != HTTPRequest.RESULT_SUCCESS:
		printerr("Error during http request, cannot check for updates")
		return
	var json := JSON.new()
	json.parse(body.get_string_from_utf8())
	var response: Dictionary = json.get_data()
	var version_string: String = response["latest"]
	version_string = version_string.split("-")[0]
	var version_array: Array = version_string.split(".")
	for i in 3:
		latest_version[i] = int(version_array[i])
	
	check_for_updates()


func check_for_updates() -> void:
	if latest_version == version:
		Message.show_message(MessageContainer.message_type.success, "The 3D Scene Packer is up to date")
	else:
		Message.show_message(MessageContainer.message_type.warning, "A new version is available")
		update_available_link.text = "Update available: " + get_version_string(latest_version)
		update_available_link.show()
		

func get_version_string(version_vector: Vector3i) -> String:
	return str(version_vector.x) + "." + str(version_vector.y) + "." + str(version_vector.z)
