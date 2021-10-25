extends KinematicBody2D
class_name Player

export (float) var speed = 200
export (float) var shoot_cooldown = 0.4
export (int) var hp = 3


var velocity = Vector2.ZERO
var dir = Vector2.ZERO

onready var bullet = preload("res://games/game-1/scenes/Bullet.tscn")
onready var shoot_timer = $shoot_cooldown

func _ready() -> void:
	Global1.emit_signal("on_player_life_changed",hp)

func _process(delta: float) -> void:
	if hp <= 0:
		queue_free()
	
func _physics_process(delta: float) -> void:
	#check input
	get_input()
	
func get_input():
	if Input.is_action_pressed("shoot") and shoot_timer.is_stopped():
		shoot_timer.start(shoot_cooldown)
		var player_bullet = bullet.instance()
		player_bullet.global_position = position
		get_tree().current_scene.add_child(player_bullet)
		
	dir.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	dir.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	dir.normalized()
	velocity = dir * speed
	
	velocity = move_and_slide(velocity)


func _on_Area2D_area_entered(area: Area2D) -> void:
	if area is enemy:
		hp -= 1
		print('HP:' + str(hp))
		Global1.emit_signal("on_player_life_changed",hp)
