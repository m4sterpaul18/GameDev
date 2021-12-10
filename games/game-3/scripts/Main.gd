extends Node2D
#latest score
onready var latest_score = $"Boats/Path_4/follow_4/Player/Camera2D/UI/game_over/TextureRect/Highscore/latest_score"
onready var stopwatch_label = $"Boats/Path_4/follow_4/Player/Camera2D/UI/Stopwatch/stop_watch"
onready var game_over_screen = $"Boats/Path_4/follow_4/Player/Camera2D/UI/game_over"

var elapsed:float = 0
var running
var place = 0

var currentUser = SilentWolf.Auth.logged_in_player;


#paths
onready var path_1 = $"Boats/Path_1/follow_1"
onready var path_2 = $"Boats/Path_2/follow_2"
onready var path_3 = $"Boats/Path_3/follow_3"
onready var path_4 = $"Boats/Path_4/follow_4"

#radar paths
onready var radar_path_1 = $"Boats/Path_4/follow_4/Player/Camera2D/UI/Radar/1/follow_1"
onready var radar_path_2 = $"Boats/Path_4/follow_4/Player/Camera2D/UI/Radar/1/follow_2"
onready var radar_path_3 = $"Boats/Path_4/follow_4/Player/Camera2D/UI/Radar/1/follow_3"
onready var radar_path_4 = $"Boats/Path_4/follow_4/Player/Camera2D/UI/Radar/1/follow_4"

func _ready() -> void:
	#pause before start of the game
	get_tree().paused = true
	
	#stop sound
	Audiomanager.playing = false
	
	Global2.connect("game_over_boat",self,"_show_gameover")
	game_over_screen.visible = false
	running = true
	
	#get latest scores
	yield(SilentWolf.Scores.get_high_scores(0,"Pirates"), "sw_scores_received")
	for score in SilentWolf.Scores.scores:
		print("Player name: " + str(score.player_name) + ", score: " + str(score.score) + ", metadata: " + str(score.metadata))
		if str(score.player_name) == currentUser:
			print("Has scores!")
			latest_score.text = str(score.score) + "s"
			
func _process(delta: float) -> void:
	radar()
	
	if running:
		elapsed += delta
		stopwatch_label.text = "%0.1f" % elapsed + "s"

func _show_gameover(response:String = ""):
	if response == "lost":
		game_over_screen.visible = true
		running = false
		Global2.emit_signal("change_gameover_label")
	else:
		game_over_screen.visible = true
		running = false
	
func _on_finish_line_area_exited(area: Area2D) -> void:

	if area.is_in_group('Player'):
		place += 1
		Global2.emit_signal("game_over_boat","")
		Global2.emit_signal("place",place)
		
	elif area.is_in_group('A.I'):
		if running:
			place += 1
			print('finished place for AI #'+str(place))

func radar():
	radar_path_1.unit_offset = path_1.unit_offset
	radar_path_2.unit_offset = path_2.unit_offset 
	radar_path_3.unit_offset = path_3.unit_offset
	radar_path_4.unit_offset = path_4.unit_offset

func pause():
	get_tree().paused = true

func resume():
	get_tree().paused = false



