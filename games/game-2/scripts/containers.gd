extends Control

export(String, "none", "int", "char", "float", "array","bool") var type

onready var target_area = $"containers"
onready var splash_sound = $'splash'
onready var wrong_sound = $"wrong"

func _ready() -> void:
	randomize()
	target_area.add_to_group(type)
	
func squish():
	splash_sound.pitch_scale = rand_range(0.6,1.3)
	splash_sound.play()
	$AnimationPlayer.play("squash")

func wrong_squish():
	wrong_sound.pitch_scale = rand_range(0.6,1.3)
	wrong_sound.play()
	$AnimationPlayer.play("squash")
