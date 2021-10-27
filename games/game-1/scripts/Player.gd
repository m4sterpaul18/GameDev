extends KinematicBody2D
class_name Player

export (float) var speed = 200
export (float) var shoot_cooldown = 0.6
export (int) var hp = 3


var velocity = Vector2.ZERO
var dir = Vector2.ZERO

onready var bullet = preload("res://games/game-1/scenes/Bullet.tscn")
onready var shoot_timer = $shoot_cooldown

#sounds
onready var shoot_sound = $"shoot"
onready var explode_sound = $"explode"
onready var powerup_sound = $"powerup"
onready var debuff_sound = $"debuff"

onready var animation = $"AnimationPlayer"

func _ready() -> void:
	#to avoid bug collision shape is not active
	$"Area2D/CollisionShape2D".disabled = false
	randomize()
	#connect Global1 signals

	Global1.connect("answer_is_correct",self,"_answer_is_correct")
	Global1.connect("answer_is_wrong",self,"_answer_is_wrong")
	Global1.connect("explode_sound",self,"_play_explode_sound")
	Global1.emit_signal("on_player_life_changed",hp)
	Global1.connect("damage_player_by_enemy",self,"damage_player")

func _process(delta: float) -> void:
	if hp <= 0:
		queue_free()
	
func _physics_process(delta: float) -> void:
	#check input
	get_input()
	
func get_input():
	if Input.is_action_pressed("shoot") and shoot_timer.is_stopped():
		shoot_sound.play()
		shoot_timer.start(shoot_cooldown)
		var player_bullet = bullet.instance()
		player_bullet.global_position = position
		get_tree().current_scene.add_child(player_bullet)
		
	dir.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	dir.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	dir.normalized()
	velocity = dir * speed
	
	velocity = move_and_slide(velocity)


func _on_Area2D_area_entered(area: Area2D) -> void:
	if area is enemy:
		damage_player()
		print('HP:' + str(hp))
		

func damage_player():
	hp -= 1
	Global1.emit_signal("on_player_life_changed",hp)
	animation.play("damaged")
		
func _play_explode_sound():
	explode_sound.play()

func _answer_is_correct():
	var rng = int(rand_range(1,4))
	generate_powerup(rng)
	

func _answer_is_wrong():
	var rng = int(rand_range(1,4))
	generate_debuffs(rng)
	
	
func generate_powerup(rng:int):
	powerup_sound.play()
	
	if rng == 1:
		animation.play("+hp")
		changeHP(1)
	elif rng == 2:
		animation.play("+speed")
		changeSpeed(100)
	elif rng == 3:
		animation.play("+bullet")
		changeBulletSpeed(-0.1)
	
func generate_debuffs(rng:int):
	debuff_sound.play()
	
	if rng == 1:
		animation.play("-hp")
		changeHP(-1)
	elif rng == 2:
		animation.play("-speed")
		changeSpeed(-100)
	elif rng == 3:
		animation.play("-bullet")
		changeBulletSpeed(0.1)

func changeHP(amount:int):
	hp += amount
	Global1.emit_signal("on_player_life_changed",hp)
	if amount < 0:
		animation.play("damaged")

func changeSpeed(amount:int):
	#minimum speed is 100 only
	if speed <= 100 and amount < 100:
		print("speed already max slow!")
		return
	speed += amount
	

func changeBulletSpeed(amount:float):
	print("base cooldown:" + str(shoot_cooldown))
	print("to be added or deducted" + str(amount))
	
	if(shoot_cooldown < 0.3 and amount < 0):
		print("already max!")
		return
	else:
		shoot_cooldown += amount
		
	print("new cooldown is:" + str(shoot_cooldown))
