extends Control

@export var container : VBoxContainer

func _on_retry_level_button_down() -> void:
	get_tree().reload_current_scene()


func _on_quit_button_down() -> void:
	get_tree().quit()
