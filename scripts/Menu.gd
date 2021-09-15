extends Control

onready var version = $Version
# Called when the node enters the scene tree for the first time.
func _ready():
	version.text = "Version " + str(SilentWolf.config.game_version)


