extends Control

onready var version = $Version
# Called when the node enters the scene tree for the first time.
func _ready():
	version.text = "Version " + str(SilentWolf.config.game_version)
	SilentWolf.Scores.wipe_leaderboard('main')

func _on_Credits_pressed() -> void:
	get_tree().change_scene("res://scenes/Credits.tscn")
