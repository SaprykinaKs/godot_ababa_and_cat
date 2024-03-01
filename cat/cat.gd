extends CharacterBody2D

# Энумератор для состояний персонажа
enum CharacterState {
	IDLE,
	RUN,
	JUMP
}

# Параметры движения
var movement_speed = 200
var jump_force = -150  # Увеличиваем силу прыжка для лучшего эффекта

# Гравитация
const GRAVITY = 300  # Увеличиваем силу гравитации для лучшего эффекта

# Состояние персонажа
var character_state = CharacterState.IDLE

# Скорость персонажа
#var velocity = Vector2()

func _physics_process(delta):
	# Управление движением
	var move_direction = 0
	if Input.is_action_pressed("move_right"):
		move_direction += 1
		$AnimatedSprite2D.scale.x = 1  # 
	if Input.is_action_pressed("move_left"):
		move_direction -= 1
		$AnimatedSprite2D.scale.x = -1  # 

	# Применение движения
	velocity.x = move_direction * movement_speed  # Задаем только горизонтальную скорость
	move_and_slide()

	# Применение гравитации
	if not is_on_floor():
		velocity.y += GRAVITY * delta  # Учитываем гравитацию

	# Управление анимациями
	update_animation(move_direction)

	# Управление прыжком
	if is_on_floor() && Input.is_action_just_pressed("jump"):
		apply_jump_impulse()

func update_animation(move_direction):
	if move_direction != 0:
		character_state = CharacterState.RUN
	else:
		character_state = CharacterState.IDLE

	if character_state == CharacterState.RUN:
		$AnimatedSprite2D.play("run")
	elif character_state == CharacterState.IDLE:
		$AnimatedSprite2D.play("idle")
	elif character_state == CharacterState.JUMP:
		$AnimatedSprite2D.play("jump")

func apply_jump_impulse():
	character_state = CharacterState.JUMP
	$AnimatedSprite2D.play("jump")
	velocity.y = jump_force  # Задаем вертикальную скорость для прыжка
