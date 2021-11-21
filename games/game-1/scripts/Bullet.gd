extends Area2D
class_name bullet

export (int) var damage = 1
export (float) var bullet_speed = 200

#var velocity = Vector2(rand_range(-1,1),0)

func _physics_process(delta: float) -> void:
	#position += velocity.rotated(rotation)
	position.y -= bullet_speed * delta
	

func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()


func _on_Bullet_area_entered(area: Area2D) -> void:
	if area.is_in_group('damageable'):
		area.damage(damage)
		queue_free()
