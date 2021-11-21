extends enemy

onready var firing_cooldown = $"firing_cooldown"

func _process(delta: float) -> void:
	
	if firing_cooldown.is_stopped():
		fire()
		firing_cooldown.start()

