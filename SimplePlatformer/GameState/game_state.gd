extends Node

@export var current_level := 0
@export var levels : Array[Resource]

func load_level():
	var scene
	# Alle Level sind gespielt:
	if current_level == levels.size():
		get_tree().quit()
	else:
		scene = levels[current_level]
		get_tree().change_scene_to_packed(scene)
