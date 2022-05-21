extends RigidBody2D

export var min_speed = 150.0
export var max_speed = 250.0

func _ready():
	get_node("AnimatedSprite").playing = true
	var mob_types = get_node("AnimatedSprite").frames.get_animation_names()
	get_node("AnimatedSprite").animation = mob_types[randi() % mob_types.size()]


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
