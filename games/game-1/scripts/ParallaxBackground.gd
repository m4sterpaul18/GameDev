extends ParallaxBackground

export(float) var speed = 200

func _process(delta: float) -> void:
	scroll_offset.y += speed * delta 
