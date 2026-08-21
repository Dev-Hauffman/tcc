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
