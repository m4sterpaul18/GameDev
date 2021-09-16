extends Control

onready var scoreLabel = $Click/Scorelabel
onready var particles = $CPUParticles2D
onready var process = $Process
onready var user = SilentWolf.Auth.logged_in_player

var ldboard = "main"
# Called when the node enters the scene tree for the first time.
func _ready():
	process.visible = false

func _process(delta):
	if (int(scoreLabel.text) !=0 and int(scoreLabel.text)  % 50 == 0):
		particles.emitting = true;
	else:
		particles.emitting = false;
		
func _on_Click_pressed():
	process.visible = false
	var score = int(scoreLabel.text) + 1
	scoreLabel.text = str(score)
	
func _on_Submit_pressed():
	var scoreToSubmit = int(scoreLabel.text)
	process.visible = true
	process.text = "Processing..."
	SilentWolf.Scores.persist_score(user, scoreToSubmit,ldboard)
	var results = ("Score submitted successfully")
	scoreLabel.text = "0"
	process.text = results
	


func _on_Goback_pressed():
	get_tree().change_scene("res://scenes/Dashboard.tscn")
