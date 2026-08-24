class_name Level
extends Resource

@export var level_info:Array[LevelInfo]
@export var level_title:String


func add_level_title(level_name:String) -> void:
	level_title = level_name


func append_level(level_data:LevelInfo) -> void:
	level_info.append(level_data)


func is_empty() -> bool:
	return level_info.is_empty()


func get_first_scene() -> String:
	var scene_name:String
	for scene in level_info:
		if scene.starter:
			scene_name = scene.title
	if scene_name.is_empty():
		print_debug("'scene_name' is empty on 'get_first_scene' at resource class 'Level'")
		assert(false)
	return scene_name
