extends Node

signal on_player_life_changed(life)
signal explode_sound


#signals if answer is correct
signal answer_is_correct
signal answer_is_wrong

#signal to resume game
signal resume

var score:int = 0
