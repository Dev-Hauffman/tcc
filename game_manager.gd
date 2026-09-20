class_name GameManager
extends Node


@export var scenes:Node
@export var main_menu_scene:MainMenu

@export var file_processor:FileProcessor
@export var levels:Array[Level] = []


func _ready() -> void:
	read_levels()
	main_menu_scene.start_button_pressed.connect(load_choose_level)


func read_levels() -> void:
	print_debug("reading levels")
	var path:String = OS.get_user_data_dir()
	print_debug("System path: " + path)
	var dir:DirAccess = DirAccess.open(path)
	var dir_error:Error = dir.get_open_error()
	if dir_error != OK:
		print_debug("Error opening directory: %s. ERROR %d" % [path, dir_error])
	if dir:
		for file_name in dir.get_files():
			var extension:String = file_name.get_extension()
			if extension == "twee":
				print_debug("File name: " + file_name)
				var file_path:String = path + "/" + file_name
				print_debug("File path: " + file_path)
				var file:FileAccess = FileAccess.open(file_path, FileAccess.READ)
				var file_error:Error = file.get_open_error()
				if file_error != OK:
					print_debug("Error opening file: %s. ERROR %d" % [file_name, file_error])
				var level:Level = file_processor.process_twee_file(file, path)
				if not level.is_empty():
					level.add_level_title(file_name)
					levels.append(level)
				else:
					print_debug("level '%s' is empty" % file_name)


func load_choose_level() -> void:
	clear_scenes_children()
	var choose_level_scene:ChooseLevel = load("res://scenes/choose_level.tscn").instantiate()
	choose_level_scene.hide()
	scenes.add_child(choose_level_scene)
	choose_level_scene.display_levels(levels)
	choose_level_scene.level_chosen.connect(load_level_manager)


func load_level_manager(level:Level) -> void:
	print_debug("loaded")
	clear_scenes_children()
	var level_manager:LevelManager = load("res://scenes/level_manager.tscn").instantiate()
	scenes.add_child(level_manager)
	level_manager.result_scene_requested.connect(load_result_scene)
	level_manager.initialize_level_manager(level)
	level_manager.load_level_scene(level.get_first_scene())


func load_result_scene(feedbacks:Array) -> void:
	clear_scenes_children()
	var result_scene:ResultScene = load("res://scenes/result_scene.tscn").instantiate()
	result_scene.main_menu_requested.connect(load_main_menu)
	result_scene.initialize_result_scene(feedbacks)
	scenes.add_child(result_scene)


func load_main_menu() -> void:
	clear_scenes_children()
	if main_menu_scene != null:
		scenes.add_child(main_menu_scene)
	else:
		var main_menu:MainMenu = load("res://scenes/main_menu.tscn").instantiate()
		main_menu.start_button_pressed.connect(load_choose_level)
		scenes.add_child(main_menu)


func clear_scenes_children() -> void:
	for child in scenes.get_children():
		child.queue_free()
