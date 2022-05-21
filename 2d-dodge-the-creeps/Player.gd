extends Area2D

signal hit

export var speed = 400.0
var screen_size = Vector2.ZERO

func _ready():
	screen_size = get_viewport_rect().size
	#print(screen_size)

func _process(delta):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	
	if direction.length() > 0:
		direction = direction.normalized()
		get_node("AnimatedSprite").play()
	else:
		get_node("AnimatedSprite").stop()
	
	position += direction * speed * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if direction.x != 0:
		get_node("AnimatedSprite").animation = "right"
		get_node("AnimatedSprite").flip_h = direction.x < 0
		get_node("AnimatedSprite").flip_v = false
	elif direction.y != 0:
		get_node("AnimatedSprite").animation = "up"
		get_node("AnimatedSprite").flip_v = direction.y > 0

func start(new_position):
	position = new_position
	show()
	$CollisionShape2D.disabled = false

func _on_Player_body_entered(_body):
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
	emit_signal("hit")
