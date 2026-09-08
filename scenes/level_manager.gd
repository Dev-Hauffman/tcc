class_name LevelManager
extends Node


signal result_scene_requested(feedback:Array)


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
	scene.result_button_pressed.connect(send_feedback_result)
	add_child(scene)

func load_level_scene(scene_name:String) -> void:
	for level in level_data.level_info:
		if scene_name == level.title:
			level.was_visited = true
			scene.initialize_level_scene(level, level_data, inactive)


func send_feedback_result() -> void:
	var feedback:Array = gather_feedback()
	emit_signal("result_scene_requested", feedback)


func gather_feedback() -> Array:
	var feedback:Array = []
	for level_info in level_data.level_info:
		if not level_info.was_visited and not level_info.feedback.is_empty():
			feedback.append(level_info.feedback)
	return feedback
