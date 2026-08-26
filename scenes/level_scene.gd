class_name LevelScene
extends Control


@export var background_image:Sprite2D
@export var image:TextureRect
@export var text:RichTextLabel


func initialize_level_scene(level_info:LevelInfo) -> void:
	background_image.texture = level_info.image
	image.texture = level_info.image
	if level_info.text.is_empty():
		text.hide()
	else:
		text.show()
	text.text = level_info.text
