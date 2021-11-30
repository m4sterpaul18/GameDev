extends Control



func _on_Back_pressed() -> void:
	get_tree().change_scene("res://scenes/Gameselect.tscn")

func _on_PLAY_pressed() -> void:
	get_tree().change_scene("res://games/game-2/scenes/Main.tscn")
