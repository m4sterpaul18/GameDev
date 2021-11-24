extends Node2D

#preloads
onready var fishes = preload("res://games/game-2/scenes/fishes.tscn")

#onready references
onready var score_label = $"CanvasLayer/UI/score"
onready var barrel_container = $"barrels"
onready var gameover_screen = $"CanvasLayer/game_over"

func _ready() -> void:
	gameover_screen.visible = false
	randomize()
	Global2.connect("add_score",self,"_add_score")
	Global2.connect("gameover",self,"_show_gameover")
	
	shuffle_containers()
	
func spawn_fish():
	var spawn_fish = fishes.instance()
	spawn_fish.position = Vector2(-145,rand_range(130,570))
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
