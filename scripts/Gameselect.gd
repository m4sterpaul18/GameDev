extends Control

var array = []
var args = PoolStringArray(array)

func _on_Button_pressed() -> void:
	OS.execute('res://games/JumpyBoxy/JumpyBoxy.exe',args)
