extends Control


onready var greetText = $Greet;
var currentUser = SilentWolf.Auth.logged_in_player;

func _ready():
	greetText.text = "Hello " + str(currentUser);




func _on_Play_pressed():
	get_tree().change_scene("res://scenes/Test.tscn")


func _on_Reset_pressed():
	  SilentWolf.Scores.wipe_leaderboard("main")
