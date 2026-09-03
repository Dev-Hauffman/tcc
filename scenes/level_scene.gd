class_name LevelScene
extends Control


signal scene_button_pressed(level_info:LevelInfo)
signal deactivated_scenes(deactivated:Array)


@export var background_image:Sprite2D
@export var image:TextureRect
@export var text:RichTextLabel
@export var scene_button_container:VBoxContainer


func initialize_level_scene(level_info:LevelInfo, level_data:Level, inactive:Array) -> void:
	background_image.texture = level_info.image
	image.texture = level_info.image
	if level_info.get_dialog_text().is_empty():
		text.hide()
	else:
		text.show()
	text.text = level_info.get_dialog_text()
	populate_buttons(level_info, level_data, inactive)
	if not level_info.deactivate.is_empty():
		emit_signal("deactivated_scenes", level_info.deactivate)


func populate_buttons(level_info:LevelInfo, level_data:Level, inactive:Array) -> void:
	for child in scene_button_container.get_children():
		child.queue_free()
	for connection in level_info.connections:
		var scene_button:SceneButton = load("res://scenes/scene_button.tscn").instantiate()
		var scene:LevelInfo = find_scene(connection, level_data, inactive)
		if scene != null:
			scene_button.text = scene.get_button_text()
			scene_button.pressed.connect(func(): emit_signal("scene_button_pressed", scene))
			scene_button_container.add_child(scene_button)


func find_scene(level_name:String, level_data:Level, inactive:Array) -> LevelInfo:
	var result:LevelInfo
	for entry in inactive:
		if level_name == entry:
			return result
	for scene in level_data.level_info:
		if scene.title == level_name:
				result = scene
	return result
