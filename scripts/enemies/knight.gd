extends Enemy

@export var stats : Resource

func _ready() -> void:
	$Sprite2D.texture = stats.sprite
