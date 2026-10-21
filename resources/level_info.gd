class_name LevelInfo
extends Resource

@export var title:String
@export var dialog_text:String
@export var button_text:String
@export var image:ImageTexture
@export var sound:AudioStreamWAV
@export var activate:Array = []
@export var deactivate:Array = []
@export var feedback:String
@export var connections:Array = []
@export var starter:bool = false
@export var is_active:bool = true
@export var was_visited:bool = false


func set_title(new_title:String) -> void:
	title = new_title


func set_text(new_text:String) -> void:
	dialog_text = new_text


func set_button_text(new_text:String) -> void:
	button_text = new_text


func set_image(new_image:ImageTexture) -> void:
	image = new_image


func set_sound(new_sound:AudioStreamWAV) -> void:
	sound = new_sound


func set_activate(new_activate:Array) -> void:
	activate = new_activate


func set_deactivate(new_deactivate:Array) -> void:
	deactivate = new_deactivate


func set_feedback(new_feedback:String) -> void:
	feedback = new_feedback


func set_connections(new_connections:Array) -> void:
	connections = new_connections


func set_is_active(value:bool) -> void:
	is_active = value


func set_was_visited(value:bool) -> void:
	was_visited = value


func get_dialog_text() -> String:
	return dialog_text


func get_button_text() -> String:
	return button_text
