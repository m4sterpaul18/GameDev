extends Control



onready var logout_window = $"LogoutWindow"
onready var greetText = $Welcome/CenterContainer/Greet;
var currentUser = SilentWolf.Auth.logged_in_player;

onready var student_id_window = $"addStudentId"
onready var student_id_input = $"addStudentId/TextureRect/VBoxContainer"

#input
onready var student_id = $"addStudentId/TextureRect/VBoxContainer/id_input"

onready var student_id_error = $"addStudentId/TextureRect/VBoxContainer/error"
onready var student_id_success = $"addStudentId/TextureRect/success"

func _ready():
	greetText.text = "Hello " + str(currentUser);
	logout_window.hide()
	
	#var item_to_delete = { "student-id": "" }
	#SilentWolf.Players.delete_player_data(currentUser, item_to_delete)

	yield(SilentWolf.Players.get_player_data(currentUser), "sw_player_data_received")
	
	if(! SilentWolf.Players.player_data.empty()):
		student_id_window.visible = false
		print("has value")
		print(SilentWolf.Players.player_data)
	else:
		student_id_window.visible = true
		
	


func _on_Play_pressed():
	get_tree().change_scene("res://scenes/Gameselect.tscn")


func _on_Ranking_pressed() -> void:
	get_tree().change_scene("res://addons/silent_wolf/Scores/Leaderboard.tscn")


func _on_Logout_pressed() -> void:
	logout_window.show()


func _on_No_pressed() -> void:
	logout_window.hide()


func _on_Yes_pressed() -> void:
	#logout player
	SilentWolf.Auth.logout_player()
	get_tree().change_scene("res://scenes/Menu.tscn")


func _on_add_id_pressed() -> void:
	#add to silent wolf player data
	if(student_id.text.length() == 10):
		print("valid")
		print(student_id.text)
		
		var player_data = {
			'student-id':student_id.text
		}
		
		SilentWolf.Players.post_player_data(currentUser, player_data)
		print("success")
		_data_added()
	else:
		print("invalid ID")
		student_id_error.visible = true


func _on_okay_pressed() -> void:
	student_id_window.visible = false

func _data_added():
	student_id_input.visible = false
	student_id_success.visible = true


func _on_Settings_pressed() -> void:
	get_tree().change_scene("res://scenes/Settings.tscn")

