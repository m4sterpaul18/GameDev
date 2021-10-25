extends Node2D

onready var spawn_timer = $'spawn_timer'
onready var score_label = $"CanvasLayer/HUD/score_label"
onready var gameover_screen = $"CanvasLayer/HUD/gameover_screen"

var enemies = [
	preload("res://games/game-1/scenes/enemy_1.tscn"),
	preload("res://games/game-1/scenes/enemy_2.tscn")
	]

func _ready() -> void:
	randomize()
	gameover_screen.visible = false
	Global1.connect("on_player_life_changed",self,"_on_check_life")
	
func _process(delta: float) -> void:
	score_label.text = str(Global1.score)
	
func _on_spawn_timer_timeout() -> void:
	spawn_enemy()
	
func spawn_enemy():
	var enemy_instance = enemies[randi() % enemies.size()]
	var spawn_enemy = enemy_instance.instance()
	spawn_enemy.position = Vector2(rand_range(10,1200),-50)
	get_tree().current_scene.add_child(spawn_enemy) 

func _on_check_life(life: int):
	if life == 0:
		gameover_screen.visible = true
