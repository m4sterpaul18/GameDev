extends Node2D

onready var spawn_timer = $'spawn_timer'
onready var score_label = $'Control/score_label'
onready var game_over = $'Control/ColorRect/game_over'
onready var game_over_score = $'Control/ColorRect/game_over/final_score/score'

var enemies = [
	preload("res://games/game-1/scenes/enemy_1.tscn"),
	preload("res://games/game-1/scenes/enemy_2.tscn")
	]

func _ready() -> void:
	game_over.visible = false
	randomize()
	
func _process(delta: float) -> void:
	score_label.text = str(Global1.score)
	
func _on_spawn_timer_timeout() -> void:
	spawn_enemy()
	
func spawn_enemy():
	var enemy_instance = enemies[randi() % enemies.size()]
	var spawn_enemy = enemy_instance.instance()
	spawn_enemy.position = Vector2(rand_range(10,1200),-50)
	get_tree().current_scene.add_child(spawn_enemy) 
