extends TileMapLayer

@export var player : CharacterBody2D

signal open_door()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		open_door.emit()
		
