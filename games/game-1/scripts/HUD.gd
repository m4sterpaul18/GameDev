extends Control

onready var lifebar := $'life_container'
onready var life := preload("res://games/game-1/scenes/lives.tscn")

func _ready() -> void:
	clear_lives()
	Global1.connect("on_player_life_changed",self,"_on_player_life_changed")
	
func clear_lives():
	for child in lifebar.get_children():
		get_parent().remove_child(child)
		child.queue_free()
	
func add_lives(lives: int):
	clear_lives()
	for i in range(lives):
		lifebar.add_child(life.instance())
	
func _on_player_life_changed(lives: int):
	add_lives(lives)
