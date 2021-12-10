extends Camera2D

export var amount = 0.2

export var max_offset = Vector2(80, 55)  # Maximum hor/ver shake in pixels.

export var max_roll = 0.1  # Maximum rotation in radians (use sparingly).

onready var noise = OpenSimplexNoise.new()

var noise_y = 0

var shake_camera = false

func _ready():
	Global2.connect("camera_boat_shake",self,"_start_shake")
	randomize()
	noise.seed = randi()
	noise.period = 4
	noise.octaves = 2

func _process(delta: float) -> void:
	if shake_camera and $"shake_time".time_left > 0:
		_shake()
		
func _start_shake():
	$"shake_time".start()
	shake_camera = true
	
func _shake():
	noise_y += 1
	rotation = max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
	offset.x = max_offset.x * amount * noise.get_noise_2d(noise.seed*2, noise_y)
	offset.y = max_offset.y * amount * noise.get_noise_2d(noise.seed*3, noise_y)


func _on_shake_time_timeout() -> void:
	shake_camera = false
