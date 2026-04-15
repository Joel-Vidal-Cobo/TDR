extends Node2D

func _ready() -> void:
	get_tree().paused = false
	if Global.night < 7:
		SaveData.load_game()
