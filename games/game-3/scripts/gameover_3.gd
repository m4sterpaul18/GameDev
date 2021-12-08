extends TextureRect

onready var score = $"VBoxContainer/score"
onready var success_label = $"VBoxContainer/success"
onready var submit_button =$'VBoxContainer/submit'

onready var label = $'VBoxContainer/scorelabel'
onready var time_elapsed = $"../../Stopwatch/stop_watch"

func _ready() -> void:
	success_label.visible = false
	Global2.connect("place",self,"_place")
	
func _process(delta: float) -> void:
	#score
	score.text = time_elapsed.text

func _on_retry_pressed() -> void:
	get_tree().reload_current_scene()


func _on_home_pressed() -> void:
	get_tree().change_scene("res://scenes/Dashboard.tscn")


func _on_submit_pressed() -> void:
	submit_button.visible = false
	
	var metadata = {
		'studentId': SilentWolf.Players.player_data['student-id']
	}
	
	SilentWolf.Scores.persist_score(SilentWolf.Auth.logged_in_player,score.text,"Pirates",metadata)
	success_label.visible = true
	
func _place(place:int):
	label.text = "You placed #" + str(place)
