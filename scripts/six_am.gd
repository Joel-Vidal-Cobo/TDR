extends CanvasLayer


func _ready() -> void:
	Global.balconyPos = "balcony1"
	Global.vent2Pos = "kitchen1"
	Global.closetPos = "room0"
	Global.vent1Pos = ""
	$"../GUI".visible = true
	$animation.animation_finished.connect(fadeDone)
	if Global.night_progress == 6 and Global.night <= 6:
		Global.night += 1
		if (Global.night - 1) == Global.night_reached:
			Global.night_reached += 1
		$animation.play("fade in")
		$chime1.play()
	elif Global.night_progress == 6 and Global.night == 7:
		if Global.night_reached == 7:
			Global.night_reached += 1
		$animation.play("fade in")
		$chime2.play()

func fadeDone(_animName: StringName) -> void:
	$"../GUI".visible = true
	if _animName == "fade in":
		$animation.play("succes")
		$cheer.play()
		SaveData.save_game()
		if Global.night_reached == 8:
			$chime2.finished.connect(cheerFinished)
		else:
			$cheer.finished.connect(cheerFinished)
	if _animName == "fade out":
		get_tree().paused = false
		var scene : PackedScene = load("res://scenes/Menu.tscn")
		get_tree().change_scene_to_packed(scene)
func cheerFinished():
	$animation.play("fade out")
