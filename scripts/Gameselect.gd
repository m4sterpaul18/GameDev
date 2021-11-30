extends Control


func _on_Cfoods_pressed() -> void:
	get_tree().change_scene("res://games/game-2/scenes/instructions.tscn")

func _on_Plane_pressed() -> void:
	get_tree().change_scene("res://games/game-1/scenes/Instructions.tscn")

func _on_Back_pressed() -> void:
	get_tree().change_scene("res://scenes/Dashboard.tscn")


