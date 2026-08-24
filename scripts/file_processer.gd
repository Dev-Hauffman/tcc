class_name FileProcessor
extends Node


func process_twee_file(file:FileAccess, path:String) -> Level:
	var line:String = file.get_line() 
	var can_save:bool = false
	var level:Level = Level.new()
	var starter_scene:String
	while !file.eof_reached():
		var node_title:String
		var text_line:String 
		var image_name:String
		var loaded_image:ImageTexture
		var activate_array:Array
		var deactivate_array:Array
		var feedback:String
		var connections:Array = []
		if line.contains("\"start\":"):
			starter_scene = line
			starter_scene = starter_scene.erase(0, 12)
			starter_scene = starter_scene.erase((starter_scene.length() - 2), 2)
		elif line.contains("::"):
			if line.contains("{"):
				node_title = line.split("{")[0]
				node_title = node_title.erase(0, 3)
				node_title = node_title.erase((node_title.length()-1))
				line = file.get_line()
				if line.contains("texto|"):
					text_line = line.split("|")[1]
					#text_line = line.erase(0, 8)
					#text_line = text_line.erase((text_line.length()-1))
				can_save = not text_line.is_empty()
				if not can_save:
					print_debug("Missing text")
				line = file.get_line()
				if line.contains("imagem|") and can_save:
					image_name = line.split("|")[1]
					#image_path = line.erase(0, 9)
					#image_path = image_path.erase((image_path.length()-1))
					if not image_name.is_empty():
						loaded_image = load_image(image_name, path)
				can_save = not image_name.is_empty()
				if not can_save:
					print_debug("missing image")
				line = file.get_line()
				if line.contains("ativar|") and can_save:
					var activate_info:String = line.split("|")[1]
					if not activate_info.is_empty():
						activate_array = activate_info.split(",")
				line = file.get_line()
				if line.contains("desativar|") and can_save:
					var deactivate_info:String = line.split("|")[1]
					if not deactivate_info.is_empty():
						deactivate_array = deactivate_info.split(",")
				line = file.get_line()
				if line.contains("feedback|") and can_save:
					feedback = line.split("|")[1]
		line = file.get_line()
		if line.contains("[[") and line.contains("]]") and can_save:
			while line.contains("[[") and line.contains("]]"):
				line = line.erase(0, 2)
				line = line.erase((line.length() - 2), 2)
				connections.append(line)
				print_debug(connections)
				line = file.get_line()
		if can_save:
			print_debug("Title:%s" % node_title)
			print_debug("Text:%s|Image:%s" % [text_line, image_name])
			print_debug("Activate:%s|Deactivate:%s" % [activate_array, deactivate_array])
			print_debug("Feedback:%s" % feedback)
			print_debug("Connections:%s" % [connections])
			var level_info:LevelInfo = LevelInfo.new()
			level_info.set_title(node_title)
			if not starter_scene.is_empty():
				if starter_scene == node_title:
					level_info.starter = true
			else:
				printerr("'starter_scene' info is empty when defining starter scene")
			level_info.set_text(text_line)
			level_info.set_image(loaded_image)
			level_info.set_activate(activate_array)
			level_info.set_deactivate(deactivate_array)
			level_info.set_feedback(feedback)
			level_info.set_connections(connections)
			level.append_level(level_info)
		can_save = false
	print("ended")
	return level


func load_image(image_name:String, path:String) -> ImageTexture:
	#var dir:DirAccess = DirAccess.open(path)
	#if dir:
		#for file_name in dir.get_files():
			#print(file_name)
	var full_path:String = path + "/" + image_name
	if not FileAccess.file_exists(full_path):
		printerr("Image file %s does not exist on path: %s" % [image_name, path])
		return
	var image:Image = Image.load_from_file(full_path)
	if image == null:
		printerr("Failed to load image %s" % image_name)
		return
	var texture_image = ImageTexture.create_from_image(image)
	return texture_image
