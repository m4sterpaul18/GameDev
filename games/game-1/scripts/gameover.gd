extends TextureRect

onready var score = $"scorelabel/score"

export var ldboard_name = ""


func _process(delta: float) -> void:
	score.text = str(Global1.score)


func _on_retry_pressed() -> void:
	get_tree().reload_current_scene()


func _on_home_pressed() -> void:
	pass
