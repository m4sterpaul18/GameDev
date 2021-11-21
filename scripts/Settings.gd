extends Control

var currentUser = SilentWolf.Auth.logged_in_player;

onready var student_id = $"VBoxContainer/student_id"
onready var id_input = $"VBoxContainer/student_id_input"
onready var change_id_button = $"VBoxContainer/change_id"
onready var submit_button = $"VBoxContainer/submit"

onready var student_id_error = $"VBoxContainer/student_id_error"

onready var success_window = $"success_window"

func _ready() -> void:
	if currentUser == "celestial":
		$"wipe_ldboard".visible = true
		
	success_window.visible = false

func _on_Settings_tree_entered() -> void:
	
	yield(SilentWolf.Players.get_player_data(currentUser), "sw_player_data_received")
	
	if(! SilentWolf.Players.player_data.empty()):
		
		print(SilentWolf.Players.player_data)
		
		student_id.text = SilentWolf.Players.player_data['student-id']


func _on_change_id_pressed() -> void:
	change_id_button.visible = false
	student_id.visible = false
	id_input.visible = true
	submit_button.visible = true
	


func _on_submit_pressed() -> void:
	var newID = id_input.text
	
	if(newID.length() == 10):
		print("valid")
		print(newID)
		
		var player_data = {
			'student-id':newID
		}
		
		SilentWolf.Players.post_player_data(currentUser, player_data)
		print("success")
		
		success_window.visible = true
	else:
		print("invalid ID")
		student_id_error.visible = true
	
	


func _on_Back_pressed() -> void:
	get_tree().change_scene("res://scenes/Dashboard.tscn")


func _on_OKAY_pressed() -> void:
	get_tree().change_scene("res://scenes/Dashboard.tscn")


func _on_Button_pressed() -> void:
	 SilentWolf.Scores.wipe_leaderboard("C-planes")
