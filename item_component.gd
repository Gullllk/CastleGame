extends Item

@onready var current_level = get_tree().current_scene

enum type {health, damage, defend}
@export var item_type : type
@export var sprite_2d : Sprite2D
#@export var health_sprite : Sprite2D
#@export var defend_sprite : Sprite2D
#@export var damage_sprite : Sprite2D

var damage_sprite = "res://assets/sprites/damage_sprite.png"
var defend_sprite = "res://assets/sprites/defend_sprite.png"
var health_sprite = "res://assets/sprites/health_sprite.png"

signal picked_up(type)

func _ready() -> void:
	if item_type == type.health:
		sprite_2d.texture = load(health_sprite)
	elif item_type == type.damage:
		sprite_2d.texture = load(damage_sprite)
	elif item_type == type.defend:
		sprite_2d.texture = load(defend_sprite)



func _on_item_area_body_entered(body: Node2D) -> void:
	if body == current_level.player:
		picked_up.emit(type)
