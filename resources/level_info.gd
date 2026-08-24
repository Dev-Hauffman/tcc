class_name LevelInfo
extends Resource

@export var title:String
@export var text:String
@export var image:ImageTexture
@export var activate:Array = []
@export var deactivate:Array = []
@export var feedback:String
@export var connections:Array = []
@export var starter:bool = false


func set_title(new_title:String) -> void:
	title = new_title


func set_text(new_text:String) -> void:
	text = new_text


func set_image(new_image:ImageTexture) -> void:
	image = new_image


func set_activate(new_activate:Array) -> void:
	activate = new_activate


func set_deactivate(new_deactivate:Array) -> void:
	deactivate = new_deactivate


func set_feedback(new_feedback:String) -> void:
	feedback = new_feedback


func set_connections(new_connections:Array) -> void:
	connections = new_connections
