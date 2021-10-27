extends Node2D

onready var quiz = preload("res://scenes/Quiz.tscn")

onready var spawn_timer = $'spawn_timer'
onready var score_label = $"CanvasLayer/HUD/score_label"
onready var gameover_screen = $"CanvasLayer/HUD/gameover_screen"
onready var generate_quiz_timer = $"generate_quiz_timer"

var is_alive = true

var enemies = [
	preload("res://games/game-1/scenes/enemy_1.tscn"),
	preload("res://games/game-1/scenes/enemy_2.tscn"),
	preload("res://games/game-1/scenes/enemy_3.tscn")
	]

func _ready() -> void:
	randomize()
	gameover_screen.visible = false
	Global1.connect("resume",self,"_resume")
	Global1.connect("on_player_life_changed",self,"_on_check_life")
	
func _process(delta: float) -> void:
	difficulty()
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
		is_alive = false
		gameover_screen.visible = true


func _on_World_tree_entered() -> void:
	Global1.score = 0

func difficulty():
	if (Global1.score >= 250 and Global1.score <= 450 ):
		spawn_timer.wait_time = 0.6
		#print("spawn time:" + str(spawn_timer.wait_time))
		
	elif (Global1.score >= 451 and Global1.score <= 650 ):
		spawn_timer.wait_time = 0.5
		#print("spawn time:" + str(spawn_timer.wait_time))
		
	elif (Global1.score >= 651 and Global1.score <= 850 ):
		spawn_timer.wait_time = 0.4
		#print("spawn time:" + str(spawn_timer.wait_time))
	
	elif(Global1.score >= 850):
		spawn_timer.wait_time = 0.3
		#print("spawn time:" + str(spawn_timer.wait_time))


func _on_generate_quiz_timer_timeout() -> void:
	if is_alive:
		get_tree().paused = true
		var quiz_instance = quiz.instance()
		get_node("QuizCanvas").add_child(quiz_instance)

func _resume():
	
	get_tree().paused = false
	var childrenQuiz = get_node("QuizCanvas").get_children()
	
	for n in childrenQuiz:
		n.queue_free()
	
	generate_quiz_timer.start()


func _on_retry_pressed() -> void:
	get_tree().reload_current_scene()
