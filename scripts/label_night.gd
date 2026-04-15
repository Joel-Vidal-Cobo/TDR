extends Label

func _process(delta: float) -> void:
	text = "Night " + str(Global.night)
	if Global.night >= 6:
		text = "Night " + str(5)
