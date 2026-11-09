extends Node

@onready var item_picked_up_sound: AudioStreamPlayer2D = $WorldElements/ItemPickedUp2


@export var player : CharacterBody2D
@export var current_hp_label : Label
@export var stats_gained_label : Label

func _ready():
	current_hp_label.text = str(player.hp) + "/" + str(player.max_hp)
	stats_gained_label.hide()
	
	
func when_item_picked_up(item):
	item.give_stats()
	current_hp_label.text = str(player.hp) + "/" + str(player.max_hp)
	item.queue_free()
	item_picked_up_sound.play()
	if item.item_type == item.type.health:
		stats_gained_label.text = "You gained 10 max health!"
	elif item.item_type == item.type.damage:
		player.damage += 10
		stats_gained_label.text = "Your damage increased by 10!"
	elif item.item_type == item.type.defend:
		player.defend += 10
		stats_gained_label.text = "Your defense increased by 10!"
	stats_gained_label.show()
	await get_tree().create_timer(2).timeout
	stats_gained_label.hide()

func _on_item_component_picked_up(item):
	when_item_picked_up(item)
	

func _on_item_component_2_picked_up(item):
	when_item_picked_up(item)


func _on_item_component_3_picked_up(item):
	when_item_picked_up(item)
