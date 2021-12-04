extends Node2D

#preloads
onready var fishes = preload("res://games/game-2/scenes/fishes.tscn")
onready var wrong_sound = $"wrong_sound"

#onready references
onready var score_label = $"CanvasLayer/UI/score"
onready var barrel_container = $"barrels"
onready var gameover_screen = $"Game_over/game_over"
onready var over_bg = $"Game_over/over_bg"
onready var spawn_time = $"spawn_time"

func _ready() -> void:
	gameover_screen.visible = false
	over_bg.visible = false
	
	randomize()
	Global2.connect("add_score",self,"_add_score")
	Global2.connect("gameover",self,"_show_gameover")
	
	shuffle_containers()
		
func spawn_fish(wave_amount:int):
	for i in wave_amount:
		var spawn_fish = fishes.instance()
		spawn_fish.position = Vector2(-145,rand_range(217,640))
		get_node("fish_spawn").add_child(spawn_fish)

func _on_spawn_time_timeout() -> void:
	#difficulty and add fish base on difficulty
	difficulty()

func _add_score():
	score_label.text = str(int(score_label.text) + 10)

func shuffle_containers():
	var barrel_length = barrel_container.get_children().size()
	for item in barrel_container.get_children():
		barrel_container.move_child(item,randi() % barrel_length + 1)
		
func _show_gameover():
	gameover_screen.visible = true
	over_bg.visible = true

func wrong_squish():
	wrong_sound.pitch_scale = rand_range(0.6,1.3)
	wrong_sound.play()

func difficulty():
	if int(score_label.text) <= 150:
		spawn_fish(2)
		
	elif int(score_label.text) >= 160 and int(score_label.text) <= 350:
		spawn_fish(3)
	
	elif int(score_label.text) >= 360 and int(score_label.text) <= 500:
		spawn_fish(4)
		
	elif int(score_label.text) >= 510:
		spawn_fish(5)
		
		
