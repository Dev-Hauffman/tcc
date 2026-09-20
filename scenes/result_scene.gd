class_name ResultScene
extends Control


signal main_menu_requested


@export var default_feedback:RichTextLabel
@export var feedback_container:VBoxContainer


func initialize_result_scene(feedbacks:Array) -> void:
	if not feedbacks.is_empty():
		default_feedback.hide()
		for feedback in feedbacks:
			var feedback_label:RichTextLabel = load("res://scenes/feeback_label.tscn").instantiate()
			feedback_label.text = feedback
			feedback_container.add_child(feedback_label)


func _on_return_main_menu_button_pressed() -> void:
	emit_signal("main_menu_requested")
