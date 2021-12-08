extends Control

onready var user_input= $"window/input_window/user_input"

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
	preload("res://games/game-3/scenes/questions/30.tscn")
]

func _ready() -> void:
	randomize()
	instance_question()
	
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
		user_input.text = ''
		print('correct answer:' + str(code_question[0].answer))


func instance_question():
	#if there is a child, remove first
	if get_node("window/code").get_child_count() > 0:
		get_node("window/code").get_child(0).remove_and_skip()
		
	#instance new question
	var new_question = questions[randi() % questions.size()].instance()
	new_question.rect_global_position = Vector2(0,0)
	get_node("window/code").add_child(new_question)
	
		
		
	

