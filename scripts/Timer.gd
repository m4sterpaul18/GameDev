extends Control

onready var timer = $"Timer"
onready var timer_bar = $"timerBar"
export (int) var time_max_value = 60



func _ready() -> void:
	timer.start()
	timer_bar.value = time_max_value
	timer_bar.max_value = time_max_value

func _on_Timer_timeout() -> void:
	timer_bar.value -= 1

func _process(delta: float) -> void:
	if timer_bar.value == 0:
		print("TIMEOUT")
