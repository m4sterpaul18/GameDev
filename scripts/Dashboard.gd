extends Control


onready var greetText = $Welcome/CenterContainer/Greet;
var currentUser = SilentWolf.Auth.logged_in_player;

func _ready():
	greetText.text = "Hello " + str(currentUser);




func _on_Play_pressed():
	get_tree().change_scene("res://scenes/Test.tscn")


func _on_Ranking_pressed() -> void:
	get_tree().change_scene("res://addons/silent_wolf/Scores/Leaderboard.tscn")
