extends Label

func _process(delta: float) -> void:
	if Global.night == 1:
		text = "12:00 AM\n" + str(Global.night) + "st Night"
	if Global.night == 2:
		text = "12:00 AM\n" + str(Global.night) + "nd Night"
	if Global.night == 3:
		text = "12:00 AM\n" + str(Global.night) + "rd Night"
	if Global.night == 4:
		text = "12:00 AM\n" + str(Global.night) + "th Night"
	if Global.night == 5:
		text = "12:00 AM\n" + str(Global.night) + "th Night"
	if Global.night == 6:
		text = "12:00 AM\n" + str(Global.night) + "th Night"
	if Global.night >= 7:
		text = "12:00 AM\n" + "Custom Night"
