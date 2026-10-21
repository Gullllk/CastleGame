extends CharacterBody2D

var direction: Vector2


func _physics_process(delta):
	move_and_slide()
	#velocity = player_dir * SPEED
	#player_direction()
	#move_and_slide()
	
func _process(delta: float) -> void:
	if Input.is_action_pressed("go_up"):
		direction = Vector2.UP
	elif Input.is_action_pressed("go_down"):
		direction = Vector2.DOWN
	elif Input.is_action_pressed("go_right"):
		direction = Vector2.RIGHT
	elif Input.is_action_pressed("go_left"):
		direction = Vector2.LEFT
	else: 
		direction = Vector2.ZERO
