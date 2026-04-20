extends Node2D

var moveTimer := 0.0

func _ready() -> void:
	$idlekill.timeout.connect(idlekilltimer)
	$timer.timeout.connect(timeout)
	$randomize.timeout.connect(randomizeTimeout)
	$timer.start()

func timeout() -> void:
	if Global.balconyPos.begins_with("hall"):
		move()
		return
		
	if randi_range(1, 20) <= Global.AI["Me"]:
		if moveTimer <= 0.0:
			move()

func _process(delta: float) -> void:
	if moveTimer > 0.0:
		moveTimer -= 30 * delta
	
	if not Global.camUp:
		if $randomize.is_stopped():
			$randomize.start()

func move() -> void:
	var old_pos = Global.balconyPos
	
	match old_pos:
		"balcony0": 
			Global.balconyPos = "balcony1"
			$"walk".volume_db = -25
			$"walk".play()
		"balcony1": 
			Global.balconyPos = "balcony2"
			$"walk".volume_db = -25
			$"walk".play()
		"balcony2": 
			Global.balconyPos = "balcony3"
			$"walk".volume_db = -25
			$"walk".play()
		"balcony3": 
			Global.balconyPos = "balcony4"
			$"walk".volume_db = -25
			$"walk".play()
		"balcony4": 
			Global.balconyPos = "balcony5"
			$"walk".volume_db = -25
			$"walk".play()
		"balcony5": 
			Global.balconyPos = "hall1"
			$timer.wait_time = 0.5 
		"living1":  Global.balconyPos = "living2"
		"living2":  Global.balconyPos = "living3"
		"living3":  Global.balconyPos = "living4"
		"living4":  Global.balconyPos = "living5"
		"hall1": Global.balconyPos = "hall2"
		"hall2": Global.balconyPos = "hall3"
		"hall3": Global.balconyPos = "hall4"
		"hall4": Global.balconyPos = "hall5"
		"hall5":
			check_door_collision()
	
	if old_pos != Global.balconyPos:
		Global.Me_moved.emit()

func check_door_collision() -> void:
	if Global.camUp == false and $"timer".timeout:
		if Global.doorClose:
			Global.balconyPos = "balcony1"
			Global.power -= 10
			$timer.wait_time = 1.0 
			$idlekill.stop()
			if has_node("DoorKnock"):
				$DoorKnock.play()
		else:
			Global.balconyPos = "office"
			jumpscare()
	else:
		$idlekill.start()

func randomizeTimeout():
	moveTimer = randi_range(50, 100)

func jumpscare():
	$timer.stop()
	Global.Mejumpscare.emit()

func idlekilltimer():
	check_door_collision()
