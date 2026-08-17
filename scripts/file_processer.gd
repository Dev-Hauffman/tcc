class_name FileProcessor
extends Node


var level_info:Array[LevelInfo] = []


func process_twee_file(file:FileAccess) -> void:
	var line:String = file.get_line() 
	while !file.eof_reached():
		if line.contains("::"):
			var can_save:bool = false
			var node_title:String = line.split("{")[0]
			var text_line:String 
			var image_path:String
			line = file.get_line()
			if line.contains("Texto: "):
				text_line = line.erase(0, 8)
				text_line = text_line.erase((text_line.length()-1))
			can_save = not text_line.is_empty()
			if not can_save:
				print_debug("Missing text")
			line = file.get_line()
			if line.contains("Imagem: ") and can_save:
				image_path = line.erase(0, 9)
				image_path = image_path.erase((image_path.length()-1))
			can_save = not image_path.is_empty()
			if not can_save:
				print_debug("Missing image")
			if can_save:
				print_debug("Text:%s|Image:%s" % [text_line, image_path])
			can_save = false
		line = file.get_line()
	print("ended")
	
