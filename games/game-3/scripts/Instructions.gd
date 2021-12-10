extends Control

func _ready() -> void:
	
	Audiomanager.playing = false

func _on_Back_pressed() -> void:
	get_tree().change_scene("res://scenes/Gameselect.tscn")


func _on_play_pressed() -> void:
	get_tree().change_scene("res://games/game-3/scenes/Main.tscn")
