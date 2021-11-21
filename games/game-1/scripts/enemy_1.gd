extends Area2D
class_name enemy

export (int) var hp = 10
export (float) var speed = 350.0
export (int) var points = 50

onready var explosion = preload("res://games/game-1/scenes/explosionparticles.tscn")
onready var enemy_bullet = preload("res://games/game-1/scenes/enemy_Bullet.tscn")
onready var firing_positions = $"firing_positions"


	
func _process(delta: float) -> void:
	position.y += speed * delta 

func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
	
	
func damage(amount:int):
	hp -= amount
	if hp <= 0:
		Global1.emit_signal("screen_shake")
		Global1.emit_signal("explode_sound")
		
		var explode = explosion.instance()
		explode.position = position
		get_parent().add_child(explode)
		Global1.score += points
		queue_free()

func fire():
	for child in firing_positions.get_children():
		var bullet = enemy_bullet.instance()
		bullet.global_position = child.global_position
		get_tree().current_scene.add_child(bullet)
		


func _on_enemy_1_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		Global1.emit_signal("explode_sound")
		var explode = explosion.instance()
		explode.position = position
		get_parent().add_child(explode)
		queue_free()
