extends AnimatedSprite2D

func _ready() -> void:
	Global.switchedCamera.connect(updateCamera)
func _process(delta: float) -> void:
	updateCamera()
func updateCamera() -> void:
	modulate = Color.html("ffffff")
	match Global.currentCamera:
		"balcony0":
			if Global.balconyPos == "balcony1":
				play("balcony1")
			elif Global.balconyPos == "balcony2":
				play("balcony2")
			elif Global.balconyPos == "balcony3":
				play("balcony3")
			elif Global.balconyPos == "balcony4":
				play("balcony4")
			elif Global.balconyPos == "balcony5":
				play("balcony5")
			else:
				play("balcony0")
		"music":
			modulate = Color.html("000000")
		"piano":
			modulate = Color.html("000000")
		"office":
			modulate = Color.html("000000")
		"hall0":
			if Global.balconyPos == "hall1":
				play("hall1")
			elif Global.balconyPos == "hall2":
				play("hall2")
			elif Global.balconyPos == "hall3":
				play("hall3")
			elif Global.balconyPos == "hall4":
				play("hall4")
			elif Global.balconyPos == "hall5":
				play("hall5")
			else:
				play("hall0")
		"kitchen0":
			if Global.vent2Pos == "kitchen1":
				play("kitchen1")
			elif Global.vent2Pos == "kitchen2":
				play("kitchen2")
			elif Global.vent2Pos  == "kitchen3":
				play("kitchen3")
			elif Global.vent2Pos  == "kitchen4":
				play("kitchen4")
			elif Global.vent2Pos  == "kitchen5":
				play("kitchen5")
			elif Global.vent2Pos  == "kitchen6":
				play("kitchen6")
			elif Global.vent2Pos  == "kitchen7":
				play("kitchen7")
			else:
				play("kitchen0")
		"otheroom0":
			if Global.closetPos == "otheroom1":
				play("otheroom1")
			elif Global.closetPos == "otheroom2":
				play("otheroom2")
			elif Global.closetPos== "otheroom3":
				play("otheroom3")
			elif Global.closetPos == "otheroom4":
				play("otheroom4")
			elif Global.closetPos == "otheroom5":
				play("otheroom5")
			else:
				play("otheroom0")
		"living0":
			if Global.balconyPos == "living1":
				play("living1")
			elif Global.balconyPos == "living2":
				play("living2")
			elif Global.balconyPos == "living3":
				play("living3")
			else:
				play("living0")
		"room0":
			if Global.closetPos == "room1":
				play("room1")
			elif Global.closetPos == "room2":
				play("room2")
			elif Global.closetPos == "room3":
				play("room3")
			elif Global.closetPos == "room4":
				play("room4")
			elif Global.closetPos == "room5":
				play("room5")
			elif not Global.closetPos.begins_with("room"):
				play("room5")
			else:
				play("room0")
		_:
			play(Global.currentCamera)
