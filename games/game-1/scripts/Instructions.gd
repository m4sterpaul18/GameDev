extends Control




func _on_Back_pressed() -> void:
	get_tree().change_scene("res://scenes/Gameselect.tscn")


func _on_Go_pressed() -> void:
	get_tree().change_scene("res://games/game-1/scenes/World.tscn")
