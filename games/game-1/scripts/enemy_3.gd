extends enemy

onready var firing_cooldown = $"firing_cooldown"

func _process(delta: float) -> void:
	print(firing_cooldown.time_left)
	if firing_cooldown.is_stopped():
		fire()
		firing_cooldown.start()

