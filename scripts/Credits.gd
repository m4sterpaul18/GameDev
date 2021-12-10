extends Control

func _process(delta: float) -> void:
	$"Credits/ScrollContainer".scroll_vertical += 1

func _on_backButton_pressed() -> void:
	get_tree().change_scene("res://scenes/Menu.tscn")
