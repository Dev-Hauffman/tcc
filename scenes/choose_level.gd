class_name ChooseLevel
extends Control


signal level_chosen(level:Level)


@export var levels_container:VBoxContainer


func display_levels(levels:Array[Level]) -> void:
	for level in levels:
		var new_button:Button = Button.new()
		new_button.text = level.level_title
		new_button.pressed.connect(func(): emit_signal("level_chosen", level))
		levels_container.add_child(new_button)
	show()
