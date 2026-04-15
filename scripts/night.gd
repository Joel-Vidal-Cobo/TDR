extends Label

func _process(delta: float) -> void:
	SaveData.load_game()
	if Global.night == 1:
		text = "Night " + str(Global.night)
	if Global.night == 2:
		text = "Night " + str(Global.night)
	if Global.night == 3:
		text = "Night " + str(Global.night)
	if Global.night == 4:
		text = "Night " + str(Global.night)
	if Global.night == 5:
		text = "Night " + str(Global.night)
	if Global.night == 6:
		text = "Night " + str(Global.night)
	if Global.night >= 7:
		text = "Custom Night"
