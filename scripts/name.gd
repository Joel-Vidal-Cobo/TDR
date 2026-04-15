extends Label

func _process(delta: float) -> void:
	
	updateCamera(Global.currentCamera)
	
func updateCamera(view : String) -> void:
	match view:
		"balcony0":
			text = "Balcony"
		"music":
			text = "Storage Room\n " + "-CAMERA DISABLED-\n" + "AUDIO ONLY"
		"piano":
			text = "Primary Bedroom\n " + "-CAMERA DISABLED-\n" + "AUDIO ONLY"
		"hall0":
			text = "Hallway"
		"kitchen0":
			text = "Kitchen"
		"otheroom0":
			text = "Second Office"
		"living0":
			text = "Living Room"
		"room0":
			text = "Secondary Bedroom"
