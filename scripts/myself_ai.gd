extends Node2D

func _ready() -> void:
	$idlekill.timeout.connect(idlekilltimer)
	$timer.timeout.connect(timeout)
	$timer.start()

func timeout() -> void:
	if randi_range(1, 40) <= Global.AI["Myself"]:
			move()

func move() -> void:
	var old_pos = Global.closetPos
	
	match old_pos:
		"room0": Global.closetPos = "room1"
		"room1": Global.closetPos = "room2"
		"room2": Global.closetPos = "room3"
		"room3": Global.closetPos = "room4"
		"room4": Global.closetPos = "room5"
		"room5": Global.closetPos = "otheroom1"
		"otheroom1":  Global.closetPos = "otheroom2"
		"otheroom2":  Global.closetPos = "otheroom3"
		"otheroom3":  Global.closetPos = "otheroom4"
		"otheroom4":  Global.closetPos = "otheroom5"
		"otheroom5":
			check_blind()

	if old_pos != Global.closetPos:
		Global.Myself_moved.emit()

func check_blind() -> void:
	if Global.camUp == false:
		if Global.blindDown and $"timer".timeout:
			Global.closetPos = ["room1","room0"].pick_random()
			Global.power -= 10
			$"idlekill".stop() 
			if has_node("WindowKnock"):
				$WindowKnock.play()
		else:
			Global.closetPos = "office"
			jumpscare()
	else:
		$"idlekill".start()

func jumpscare():
	$timer.stop()
	Global.Myselfjumpscare.emit()

func idlekilltimer():
	check_blind()
