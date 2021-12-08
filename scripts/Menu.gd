extends Control

func _on_Credits_pressed() -> void:
	get_tree().change_scene("res://scenes/Credits.tscn")


func _on_Exit_pressed() -> void:
	get_tree().quit()

