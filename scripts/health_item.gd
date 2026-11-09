extends Item

@onready var item_picked_up: AudioStreamPlayer2D = $ItemPickedUp


@onready var current_level = get_tree().current_scene
signal picked_up()


func _on_health_item_area_body_entered(body: Node2D) -> void:
	if body == current_level.player:
		picked_up.emit()
