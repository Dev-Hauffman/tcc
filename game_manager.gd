class_name GameManager
extends Node


@export var scenes:Node
@export var main_menu_scene:MainMenu

@export var file_processor:FileProcessor
@export var levels:Array[Level] = []

var choose_level_scene:ChooseLevel


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
	choose_level_scene = load("res://scenes/choose_level.tscn").instantiate()
	choose_level_scene.hide()
	scenes.add_child(choose_level_scene)
	choose_level_scene.display_levels(levels)
