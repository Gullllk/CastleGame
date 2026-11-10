extends Enemy

@onready var current_level = get_tree().current_scene
@export var stats : Resource

signal player_in_area

func _ready() -> void:
	$Sprite2D.texture = stats.sprite


func _on_enemy_area_component_body_entered(body: Node2D) -> void:
	if body == current_level.player:
		player_in_area.emit()
		
