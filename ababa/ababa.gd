extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -150.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 300


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump2") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move2_left", "move2_right")
	if direction < 0 && $Ababa.scale.x>0 :
			$Ababa.scale.x = - $Ababa.scale.x
	if direction > 0 && $Ababa.scale.x<0 :
			$Ababa.scale.x = - $Ababa.scale.x
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
