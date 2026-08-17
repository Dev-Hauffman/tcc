class_name GameManager
extends Node


@export var file_processor:FileProcessor


func _ready() -> void:
	read_levels()


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
				file_processor.process_twee_file(file)
