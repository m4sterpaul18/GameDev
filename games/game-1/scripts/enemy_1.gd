extends Area2D
class_name enemy

export (int) var hp = 10
export (float) var speed = 350.0
export (int) var points = 50


func _process(delta: float) -> void:
	position.y += speed * delta 


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
	
	
func damage(amount:int):
	hp -= amount
	if hp <= 0:
		Global1.score += points
		queue_free()
