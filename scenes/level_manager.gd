class_name LevelManager
extends Node


var level_data:Level
var scene:LevelScene


func initialize_level_manager(level:Level) -> void:
	level_data = level
	for child in get_children():
		child.queue_free()
	scene = load("res://scenes/level_scene.tscn").instantiate()
	add_child(scene)

func load_level_scene(scene_name:String) -> void:
	for level in level_data.level_info:
		if scene_name == level.title:
			scene.background_image.texture = level.image
