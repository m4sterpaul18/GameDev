extends Control

onready var timer = $"Timer"
onready var timer_bar = $"timerBar"



func _ready() -> void:
	timer.start()

func _on_Timer_timeout() -> void:
	timer_bar.value -= 1

func _process(delta: float) -> void:
	if timer_bar.value == 0:
		print("TIMEOUT")
