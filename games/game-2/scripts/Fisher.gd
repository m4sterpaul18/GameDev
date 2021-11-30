extends Node2D

onready var animated_sprite = $"AnimatedSprite"

var hooked = false

func _process(delta: float) -> void:
	get_input()
	
	if get_global_mouse_position().x >= 804:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true

func get_input():
	if Input.is_mouse_button_pressed(1):
		animated_sprite.play('hook')
	else:
		animated_sprite.play('idle')
