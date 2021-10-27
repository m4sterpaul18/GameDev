extends TextureProgress


onready var generate_quiz_timer = $".."

func _process(delta: float) -> void:
	value = generate_quiz_timer.time_left


