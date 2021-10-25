extends Control

signal correct_answer

export (String) var path = "res://json/questions-1.json"
export (int) var number_of_questions = 2

onready var question_label = $'window/question'
onready var choices = $'choices'

var final_answer
var question
var question_number

func open_file(path):
	var file = File.new()
	file.open(path,file.READ)
	var content = file.get_as_text()
	file.close()
	return content

func _ready() -> void:
	connect("correct_answer",self,"_check_answer")
	
	randomize()
	question = JSON.parse(open_file(path)).result
	question_number = str(generateRNG())
	
	print ("Question #"+question_number)
	
	#set text
	print (question["question-" + question_number]["question"])
	question_label.text = str(question["question-" + question_number]["question"])
	
	#set choices
	print (question["question-" + question_number]["choices"])
	for i in range(4):
		get_node("choices").get_child(i).text = str(question["question-" + question_number]["choices"][i])
	
func generateRNG():
	var number = int(rand_range(1, number_of_questions + 1))
	return number

func _check_answer(answer:String):
	print ("correct answer: " + str(question["question-" + question_number]["answer"]))
	var correct_answer = str(question["question-" + question_number]["answer"])
	
	if answer == correct_answer:
		print("correct!")
	else:
		print("wrong!")
func _on_A_pressed() -> void:
	final_answer = $'choices/A'.text
	print ("final answer:" + str(final_answer))
	emit_signal("correct_answer",final_answer)

func _on_B_pressed() -> void:
	final_answer = $'choices/B'.text
	print ("final answer:" + str(final_answer))
	emit_signal("correct_answer",final_answer)

func _on_C_pressed() -> void:
	final_answer = $'choices/C'.text
	print ("final answer:" + str(final_answer))
	emit_signal("correct_answer",final_answer)

func _on_D_pressed() -> void:
	final_answer = $'choices/D'.text
	print ("final answer:" + str(final_answer))
	emit_signal("correct_answer",final_answer)
