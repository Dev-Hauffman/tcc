class_name MainMenu
extends Control


signal start_button_pressed


@export var start_button:Button


func _on_start_button_pressed() -> void:
	emit_signal("start_button_pressed")
