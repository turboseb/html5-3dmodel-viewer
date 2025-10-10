extends BoxContainer

@export var parameters: Array[Node]

func update_scene() -> void:
	for parameter in parameters:
		parameter.update_scene()
