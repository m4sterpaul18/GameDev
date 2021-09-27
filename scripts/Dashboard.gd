extends Control

onready var logout_window = $"LogoutWindow"
onready var greetText = $Welcome/CenterContainer/Greet;
var currentUser = SilentWolf.Auth.logged_in_player;

func _ready():
	greetText.text = "Hello " + str(currentUser);
	logout_window.hide()


func _on_Play_pressed():
	get_tree().change_scene("res://scenes/Test.tscn")


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
