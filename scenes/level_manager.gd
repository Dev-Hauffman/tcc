class_name LevelManager
extends Node


var level_data:Level
var scene:LevelScene
var inactive:Array = []


func initialize_level_manager(level:Level) -> void:
	level_data = level
	for child in get_children():
		child.queue_free()
	scene = load("res://scenes/level_scene.tscn").instantiate()
	scene.scene_button_pressed.connect(func(level_info:LevelInfo): load_level_scene(level_info.title))
	scene.deactivated_scenes.connect(func(deactivated:Array): inactive.append_array(deactivated))
	add_child(scene)

func load_level_scene(scene_name:String) -> void:
	for level in level_data.level_info:
		if scene_name == level.title:
			scene.initialize_level_scene(level, level_data, inactive)
