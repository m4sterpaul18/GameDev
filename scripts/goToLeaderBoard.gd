extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Leaderboard_pressed():
	get_tree().change_scene("res://addons/silent_wolf/Scores/Leaderboard.tscn")
