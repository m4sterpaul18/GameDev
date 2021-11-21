extends Node2D

var is_alive = true

onready var quiz = preload("res://scenes/Quiz.tscn")

#ui variables references
onready var spawn_timer = $'spawn_timer'
onready var score_label = $"CanvasLayer/HUD/score_label"
onready var gameover_screen = $"CanvasLayer/HUD/gameover_screen"
onready var generate_quiz_timer = $"generate_quiz_timer"

#camera variables
var shake_camera = false
onready var camera = $"Camera"
onready var shake_timer = $"Camera/shake_timer"
onready var noise = OpenSimplexNoise.new()

export var max_roll = 0.1
export var max_offset = Vector2(80, 55)  
export var amount = 0.2

var noise_y = 0


#enemies preload
var enemies = [
	preload("res://games/game-1/scenes/enemy_1.tscn"),
	preload("res://games/game-1/scenes/enemy_2.tscn"),
	preload("res://games/game-1/scenes/enemy_3.tscn")
	]

func _ready() -> void:
	
	#for noise
	randomize()
	noise.seed = randi()
	noise.period = 4
	noise.octaves = 2
	
	
	gameover_screen.visible = false
	
	Global1.connect("resume",self,"_resume")
	Global1.connect("on_player_life_changed",self,"_on_check_life")
	Global1.connect("screen_shake",self,"shake")
	
func _process(delta: float) -> void:
	if shake_camera and shake_timer.wait_time > 0:
		camera_shake()
		
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
		
	elif (Global1.score >= 451 and Global1.score <= 650 ):
		spawn_timer.wait_time = 0.5
		
	elif (Global1.score >= 651 and Global1.score <= 850 ):
		spawn_timer.wait_time = 0.4
	
	elif(Global1.score >= 850):
		spawn_timer.wait_time = 0.25	


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
	
	
#camera functions below
func shake():
	shake_camera = true
	shake_timer.start()
	
func camera_shake():
	noise_y += 1
	camera.rotation = max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
	camera.offset.x = max_offset.x * amount * noise.get_noise_2d(noise.seed*2, noise_y)
	camera.offset.y = max_offset.y * amount * noise.get_noise_2d(noise.seed*3, noise_y)

func _on_shake_timer_timeout() -> void:
	shake_camera = false
	
