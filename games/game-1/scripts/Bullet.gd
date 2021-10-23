extends Area2D

export (int) var damage = 1
export (float) var bullet_speed = 200


func _physics_process(delta: float) -> void:
	position.y -= bullet_speed * delta


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()


func _on_Bullet_area_entered(area: Area2D) -> void:
	if area.is_in_group('damageable'):
		area.damage(damage)
		queue_free()
