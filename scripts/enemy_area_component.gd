extends Area2D
@export var player: CharacterBody2D


var player_is_in_area = false
signal player_in_area
signal player_out

func _on_body_entered(body: Node2D) -> void:
	if body == player:
		player_in_area.emit()
		player_is_in_area = true
		print("player is in area")
	



func _on_body_exited(body: Node2D) -> void:
	if body == player:
		player_out.emit()
		player_is_in_area = false
		print("player is out of area")
