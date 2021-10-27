extends Control

signal check_answer
#signal correct_answer
#signal wrong_answer

export (String) var path = "res://json/questions-1.json"
export (int) var number_of_questions = 5

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
func _process(delta: float) -> void:
	$timerBar.value = $Timer.time_left
	
func _ready() -> void:
	connect("check_answer",self,"_check_answer")
	
	randomize()
	question = JSON.parse(open_file(path)).result
	question_number = str(generateRNG())
	
	print ("Question #"+question_number)
	
	#set text
	print (question["question-" + question_number]["question"])
	question_label.text = str(question["question-" + question_number]["question"])
	
	#set choices
	var choices = question["question-" + question_number]["choices"]
	
	#shuffle answers
	choices.shuffle()
	
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
		Global1.emit_signal("resume")
		Global1.emit_signal("answer_is_correct")
	else:
		print("wrong!")
		Global1.emit_signal("resume")
		Global1.emit_signal("answer_is_wrong")
		
func _on_A_pressed() -> void:
	final_answer = $'choices/A'.text
	print ("final answer:" + str(final_answer))
	emit_signal("check_answer",final_answer)

func _on_B_pressed() -> void:
	final_answer = $'choices/B'.text
	print ("final answer:" + str(final_answer))
	emit_signal("check_answer",final_answer)

func _on_C_pressed() -> void:
	final_answer = $'choices/C'.text
	print ("final answer:" + str(final_answer))
	emit_signal("check_answer",final_answer)

func _on_D_pressed() -> void:
	final_answer = $'choices/D'.text
	print ("final answer:" + str(final_answer))
	emit_signal("check_answer",final_answer)


func _on_Timer_timeout() -> void:
	print("time ran out!")
	Global1.emit_signal("resume")
	Global1.emit_signal("answer_is_wrong")
