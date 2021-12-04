extends Node2D

onready var fish_sprite = $"Sprite"
onready var text_label = $"Label"
onready var animation = $"AnimationPlayer"

export(float) var speed = rand_range(40.0,130.0)

var words = ['cat','dog','rat','car','var']

var selected = false
export var data_types = [
	'int',
	'char',
	'float',
	'array',
	'bool'
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
		text_label.text = str(stepify(rand_range(0.99,9.99),0.01))
	
	elif data_types[type] == "array":
		var rand_number = randi () % words.size()
		var array_type = randi() % 2 + 1
		#single array
		if array_type == 1:
			text_label.text = words[rand_number] + str([randi() % 99 + 1])
		#multidimensional
		else:
			text_label.text = words[rand_number] + str([randi() % 10 + 1]) + str([randi() % 50 + 1])
	
	elif data_types[type] == "bool":
		var rand = randf()
		if rand > 0.5:
			text_label.text = 'true'
		else:
			text_label.text = 'false'
		
func _process(delta: float) -> void:
	drag(delta)
	position.y = clamp(position.y,205,758)

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
	#selected
	else:
		text_label.visible = true
		global_position = lerp(global_position,get_global_mouse_position(), 25 * delta)

func _on_fish_area_entered(area: Area2D) -> void:
	#damage player if fish goes to the end of screen
	if area.is_in_group('end'): 
		Global2.emit_signal("on_player_life_changed",-1)
		Global2.emit_signal("screen_shake")
		area.get_parent().wrong_squish()
		
	elif is_in_group("int"):
		if area.is_in_group('int'): #correct
			print("correct")
			area.get_parent().squish()
			Global2.emit_signal("add_score")
			queue_free()
			
		else:
			print("not int") #wrong
			area.get_parent().wrong_squish()
			Global2.emit_signal("on_player_life_changed",-1)
			Global2.emit_signal("screen_shake")
			queue_free()
			
	elif is_in_group("char"):
		if area.is_in_group('char'): #correct
			print("correct")
			area.get_parent().squish()
			Global2.emit_signal("add_score")
			queue_free()
			
		else:
			print("not char") #wrong
			area.get_parent().wrong_squish()
			Global2.emit_signal("on_player_life_changed",-1)
			Global2.emit_signal("screen_shake")
			queue_free()
	
	elif is_in_group("float"):
		if area.is_in_group('float'): #correct
			print("correct")
			area.get_parent().squish()
			Global2.emit_signal("add_score")
			queue_free()
			
		else:
			print("not float") #wrong
			area.get_parent().wrong_squish()
			Global2.emit_signal("on_player_life_changed",-1)
			Global2.emit_signal("screen_shake")
			queue_free()
	
	elif is_in_group("array"):
		if area.is_in_group('array'): #correct
			print("correct")
			area.get_parent().squish()
			Global2.emit_signal("add_score")
			queue_free()
			
		else: #wrong
			print("not array")
			area.get_parent().wrong_squish()
			Global2.emit_signal("on_player_life_changed",-1)
			Global2.emit_signal("screen_shake")
			queue_free()
	
	elif is_in_group("bool"):
		if area.is_in_group('bool'): #correct
			print("correct")
			area.get_parent().squish()
			Global2.emit_signal("add_score")
			queue_free()
			
		else: #wrong
			print("not bool")
			area.get_parent().wrong_squish()
			Global2.emit_signal("on_player_life_changed",-1)
			Global2.emit_signal("screen_shake")
			queue_free()


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()

