extends Node2D

onready var fish_sprite = $"Sprite"
onready var text_label = $"Label"
export(float) var speed = 100.0


var selected = false
export var data_types = [
	'int',
	'char',
	'float',
	'array'
]

func _ready() -> void:
	#onstart cannot see label
	text_label.visible = false

	randomize()
	
	#random sprite
	var frame = randi() % 10 + 1
	fish_sprite.frame = frame
	
	#random data types
	var type = int(rand_range(0,data_types.size()))
	add_to_group(data_types[type])
	
	#label depends on type
	if data_types[type] == "int":
		text_label.text = str(randi() % 100 + 1)
		
	elif data_types[type] == "char":
		var characters = "abcdefghijklmnopqrstuvwxyz"
		text_label.text = characters[(randi() % characters.length())]
	
	elif data_types[type] == "float":
		text_label.text = str(stepify(randf(),0.01))
	
	elif data_types[type] == "array":
		var array_type = randi() % 2 + 1
		#single array
		if array_type == 1:
			text_label.text = "arr" + str([randi() % 99 + 1])
		#multidimensional
		else:
			text_label.text = "arr" + str([randi() % 10 + 1]) + str([randi() % 50 + 1])
	
func _process(delta: float) -> void:
	drag(delta)
	position.y = clamp(position.y,130,758)

func _on_fish_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("click"):
		selected = true

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected = false

func drag(delta):
	#not selected
	if !selected:
		text_label.visible = false
		position.x += speed * delta
		#fish_sprite.rotation += 1 * delta
	#selected
	else:
		text_label.visible = true
		global_position = lerp(global_position,get_global_mouse_position(), 25 * delta)


func _on_fish_area_entered(area: Area2D) -> void:
	#damage player if fish goes to the end of screen
	if area.is_in_group('end'):
		Global2.emit_signal("on_player_life_changed",-1)
		
	elif is_in_group("int"):
		if area.is_in_group('int'):
			print("correct")
			area.get_parent().squish()
			Global2.emit_signal("add_score")
			queue_free()
			
		else:
			print("not int")
			Global2.emit_signal("on_player_life_changed",-1)
			queue_free()
			
	elif is_in_group("char"):
		if area.is_in_group('char'):
			print("correct")
			area.get_parent().squish()
			Global2.emit_signal("add_score")
			queue_free()
			
		else:
			print("not char")
			Global2.emit_signal("on_player_life_changed",-1)
			queue_free()
	
	elif is_in_group("float"):
		if area.is_in_group('float'):
			print("correct")
			area.get_parent().squish()
			Global2.emit_signal("add_score")
			queue_free()
			
		else:
			print("not float")
			Global2.emit_signal("on_player_life_changed",-1)
			queue_free()
	
	elif is_in_group("array"):
		if area.is_in_group('array'):
			print("correct")
			area.get_parent().squish()
			Global2.emit_signal("add_score")
			queue_free()
			
		else:
			print("not array")
			Global2.emit_signal("on_player_life_changed",-1)
			queue_free()


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()

