class_name LevelScene
extends Node2D


@export var background_image:Sprite2D


func initialize_level_scene(level_info:LevelInfo) -> void:
	background_image.texture = level_info.image
