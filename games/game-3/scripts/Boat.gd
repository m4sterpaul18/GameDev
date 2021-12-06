extends Node2D

onready var path = get_node("..")

export(float) var min_speed = 10.5
export(float) var max_speed = 25.5
export(String, "", "Player", "A.I") var player_type

onready var boost_timer = $"boost"
onready var player_area2d = $"Area2D"
#ai timers
onready var ai_boost_timer = $"ai_timer_boost"
onready var boost = $"ai_timer_boost/boost"

var ai_speed_boost = 2.0
var player_speed_boost = 3.0
var speed

func _ready() -> void:
	#signals
	player_area2d.add_to_group(player_type)
	Global2.connect("correct_answer",self,"_boost_speed")
	randomize()
	
	#randomness
	boost.wait_time = rand_range(10.0, 20.0)
	speed = rand_range(min_speed,max_speed)
	print(str(player_type)+" my speed:" + str(speed))	
	
	
func _process(delta: float) -> void:
	if player_type == "Player":
		if boost_timer.time_left > 0.1:
			path.offset += speed * player_speed_boost * delta
		else:
			path.offset += speed * delta
	#A.I
	else:
		if ai_boost_timer.time_left > 0.1:
			path.offset += speed * ai_speed_boost * delta
		else:
			path.offset += speed * delta
			
func _boost_speed():
	boost_timer.start()

func ai_speed_boost():
	ai_boost_timer.start(rand_range(0.5,3.5))

func _on_boost_timeout() -> void:
	ai_speed_boost()
