extends CharacterBody2D


@export var SPEED = 200.0
@export var JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.length() > 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0
		if is_on_floor():
			$AnimatedSprite2D.animation = "walk"
	
	if velocity.y < 0:
		$AnimatedSprite2D.animation = "jump_up"
	if velocity.y > 0:
		$AnimatedSprite2D.animation = "jump_down"
	
	if velocity.length() == 0 and is_on_floor():
		$AnimatedSprite2D.animation = "stand"
	
	move_and_slide()
