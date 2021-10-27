extends Area2D

export (float) var bullet_speed = 250
var velocity = Vector2(rand_range(-1,1),0)

func _ready() -> void:
	randomize()

func _physics_process(delta: float) -> void:
	
	position += velocity.rotated(rotation)
	position.y += bullet_speed * delta
	

func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()


func _on_Bullet_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		Global1.emit_signal("damage_player_by_enemy")
