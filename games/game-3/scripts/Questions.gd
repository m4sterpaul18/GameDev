extends Control

onready var user_input= $"window/input_window/user_input"
onready var pass_label = $"window/PASS/pass_label"
onready var ship_health = $"ship_health"

var number_of_pass = 3
var number_of_lives = 5

#questions preload
var questions = [
	preload("res://games/game-3/scenes/questions/1.tscn"),
	preload("res://games/game-3/scenes/questions/2.tscn"),
	preload("res://games/game-3/scenes/questions/3.tscn"),
	preload("res://games/game-3/scenes/questions/4.tscn"),
	preload("res://games/game-3/scenes/questions/5.tscn"),
	preload("res://games/game-3/scenes/questions/6.tscn"),
	preload("res://games/game-3/scenes/questions/7.tscn"),
	preload("res://games/game-3/scenes/questions/8.tscn"),
	preload("res://games/game-3/scenes/questions/9.tscn"),
	preload("res://games/game-3/scenes/questions/10.tscn"),
	preload("res://games/game-3/scenes/questions/11.tscn"),
	preload("res://games/game-3/scenes/questions/12.tscn"),
	preload("res://games/game-3/scenes/questions/13.tscn"),
	preload("res://games/game-3/scenes/questions/14.tscn"),
	preload("res://games/game-3/scenes/questions/15.tscn"),
	preload("res://games/game-3/scenes/questions/16.tscn"),
	preload("res://games/game-3/scenes/questions/17.tscn"),
	preload("res://games/game-3/scenes/questions/18.tscn"),
	preload("res://games/game-3/scenes/questions/19.tscn"),
	preload("res://games/game-3/scenes/questions/20.tscn"),
	preload("res://games/game-3/scenes/questions/21.tscn"),
	preload("res://games/game-3/scenes/questions/22.tscn"),
	preload("res://games/game-3/scenes/questions/23.tscn"),
	preload("res://games/game-3/scenes/questions/24.tscn"),
	preload("res://games/game-3/scenes/questions/25.tscn"),
	preload("res://games/game-3/scenes/questions/26.tscn"),
	preload("res://games/game-3/scenes/questions/27.tscn"),
	preload("res://games/game-3/scenes/questions/28.tscn"),
	preload("res://games/game-3/scenes/questions/29.tscn"),
	preload("res://games/game-3/scenes/questions/30.tscn"),
	preload("res://games/game-3/scenes/questions/31.tscn"),
	preload("res://games/game-3/scenes/questions/32.tscn"),
	preload("res://games/game-3/scenes/questions/33.tscn"),
	preload("res://games/game-3/scenes/questions/34.tscn"),
	preload("res://games/game-3/scenes/questions/35.tscn"),
	preload("res://games/game-3/scenes/questions/36.tscn"),
	preload("res://games/game-3/scenes/questions/37.tscn"),
	preload("res://games/game-3/scenes/questions/38.tscn"),
	preload("res://games/game-3/scenes/questions/39.tscn"),
	preload("res://games/game-3/scenes/questions/40.tscn")
]

func _ready() -> void:
	randomize()
	instance_question()

	ship_health.value = number_of_lives

func _process(delta: float) -> void:
	
	ship_health.value = lerp(ship_health.value, number_of_lives , 1)
	
	pass_label.text = str(number_of_pass) + "/3"
	
	
	if number_of_lives == 0:
		Global2.emit_signal("game_over_boat","lost")
	
func _on_user_input_text_entered(new_text: String) -> void:
	var code_question = get_node("window/code").get_children()
	
	#correct
	if new_text == code_question[0].answer:
		Global2.emit_signal("correct_answer")
		user_input.text = ''
		instance_question()		
	#wrong
	else:
		Global2.emit_signal("wrong_answer")
		Global2.emit_signal("camera_boat_shake")
		user_input.text = ''
		print('correct answer:' + str(code_question[0].answer))
		instance_question()
		change_lives_bar()
			

func instance_question():
	#if there is a child, remove first
	if get_node("window/code").get_child_count() > 0:
		get_node("window/code").get_child(0).remove_and_skip()
		
	#instance new question
	var new_question = questions[randi() % questions.size()].instance()
	new_question.rect_global_position = Vector2(0,0)
	get_node("window/code").add_child(new_question)
	
		
func _on_PASS_pressed() -> void:
	if number_of_pass > 0:
		instance_question()
		number_of_pass -= 1
	else:
		print("cant pass anymore")

func change_lives_bar():
	number_of_lives -= 1
	
