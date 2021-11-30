extends Node2D

#preloads
onready var fishes = preload("res://games/game-2/scenes/fishes.tscn")
onready var wrong_sound = $"wrong_sound"

#onready references
onready var score_label = $"CanvasLayer/UI/score"
onready var barrel_container = $"barrels"
onready var gameover_screen = $"Game_over/game_over"
onready var spawn_time = $"spawn_time"

func _ready() -> void:
	gameover_screen.visible = false
	randomize()
	Global2.connect("add_score",self,"_add_score")
	Global2.connect("gameover",self,"_show_gameover")
	
	shuffle_containers()

func _process(delta: float) -> void:
	difficulty()
		
func spawn_fish():
	var spawn_fish = fishes.instance()
	spawn_fish.position = Vector2(-145,rand_range(217,640))
	get_node("fish_spawn").add_child(spawn_fish)

func _on_spawn_time_timeout() -> void:
	spawn_fish()

func _add_score():
	score_label.text = str(int(score_label.text) + 10)

func shuffle_containers():
	var barrel_length = barrel_container.get_children().size()
	for item in barrel_container.get_children():
		barrel_container.move_child(item,randi() % barrel_length + 1)
		
func _show_gameover():
	gameover_screen.visible = true

func wrong_squish():
	wrong_sound.pitch_scale = rand_range(0.6,1.3)
	wrong_sound.play()

func difficulty():
	if int(score_label.text) >= 150 and int(score_label.text) <= 300:
		spawn_time.wait_time = 3.5
		print(spawn_time.wait_time)
	elif int(score_label.text) >= 310 and int(score_label.text) <= 450:
		spawn_time.wait_time = 3
		print(spawn_time.wait_time)
	elif int(score_label.text) >= 460:
		spawn_time.wait_time = 2.5
		print(spawn_time.wait_time)
		
