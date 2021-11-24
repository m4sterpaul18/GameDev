extends HBoxContainer

onready var lifebar := $"."
onready var life := preload("res://games/game-2/scenes/lives.tscn")
export(int) var hp = 3

func _ready() -> void:
	clear_lives()
	add_lives(hp)
	Global2.connect("on_player_life_changed",self,"_on_player_life_changed")
	
func clear_lives():
	for child in lifebar.get_children():
		get_parent().remove_child(child)
		child.queue_free()
	
func add_lives(lives: int):
	clear_lives()
	for i in range(lives):
		lifebar.add_child(life.instance())
	
func _on_player_life_changed(lives: int):
	hp += lives
	add_lives(hp)
	if hp <= 0:
		#gameover
		Global2.emit_signal("gameover")

		
