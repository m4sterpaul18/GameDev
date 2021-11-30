extends TextureRect

onready var score = $"../../CanvasLayer/UI/score"
onready var gameover_score = $"VBoxContainer/score"
onready var success_label = $"VBoxContainer/success"
onready var submit_button =$'VBoxContainer/submit'

var ldboard_name_c_foods = "C-foods"

func _ready() -> void:
	success_label.visible = false

func _on_retry_pressed() -> void:
	get_tree().reload_current_scene()

func _process(delta: float) -> void:
	gameover_score.text = score.text

func _on_home_pressed() -> void:
	get_tree().change_scene("res://scenes/Dashboard.tscn")


func _on_submit_pressed() -> void:
	submit_button.visible = false
	
	var metadata = {
		'studentId': SilentWolf.Players.player_data['student-id']
	}
	
	print('ld_name: ' + ldboard_name_c_foods)
	print('score: ' + score.text)
	
	SilentWolf.Scores.persist_score(SilentWolf.Auth.logged_in_player,score.text,ldboard_name_c_foods,metadata)
	success_label.visible = true

