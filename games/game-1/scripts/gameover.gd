extends TextureRect

onready var score = $"VBoxContainer/score"
onready var success_label = $"VBoxContainer/success"
onready var submit_button =$'VBoxContainer/submit'

export var ldboard_name = "C-planes"

func _ready() -> void:
	success_label.visible = false
	
func _process(delta: float) -> void:
	score.text = str(Global1.score)


func _on_retry_pressed() -> void:
	get_tree().reload_current_scene()


func _on_home_pressed() -> void:
	get_tree().change_scene("res://scenes/Dashboard.tscn")


func _on_submit_pressed() -> void:
	submit_button.visible = false
	
	var metadata = {
		'studentId': SilentWolf.Players.player_data['student-id']
	}
	
	SilentWolf.Scores.persist_score(SilentWolf.Auth.logged_in_player,score.text,ldboard_name,metadata)
	success_label.visible = true

