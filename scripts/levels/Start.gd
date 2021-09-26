extends Node2D

var selected = false
var mouse_offset


func _ready() -> void:
	pass
	
func _process(delta):
	if selected:
		followMouse()

func followMouse():
	position = get_global_mouse_position() + mouse_offset

func _on_Area2D_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			#mouse down
			mouse_offset = position - get_global_mouse_position()
			selected = true
		else:
			#mousereleased
			selected = false


func _on_Area2D_area_entered(area: Area2D) -> void:
	if area.is_in_group("start"):
		print("true")
		print("collider position:",area.global_position)
		print("my position:",position)
		position = area.global_position
	else:
		print('false')
