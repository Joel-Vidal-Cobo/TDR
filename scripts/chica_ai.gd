extends Node2D

var current_path: String = ""

func _ready() -> void:
	if Global.vent1Pos == "" or Global.vent1Pos == null:
		Global.vent1Pos = "ventnum11"
	
	initial_hide_all()
	force_visible_per_position(Global.vent1Pos)
	
	if has_node("timer"):
		$timer.timeout.connect(_on_timer_timeout)
		$timer.start()

func _on_timer_timeout() -> void:
	if randi_range(1, 40) <= Global.AI["Chica"]:
		move_chica()

func move_chica() -> void:
	var old_pos = Global.vent1Pos
	if old_pos == "" or old_pos == null: 
		old_pos = "ventnum11"

	match old_pos:
		"ventnum11": Global.vent1Pos = "ventnum21"
		"ventnum21":
			var r = randi_range(1, 3)
			if r == 1: current_path = "top"; Global.vent1Pos = "midtop_vent11"
			elif r == 2: current_path = "bot"; Global.vent1Pos = "bot_vent11"
			else: current_path = "mid"; Global.vent1Pos = "midtop_vent11"
		"midtop_vent11": Global.vent1Pos = "midtop_vent21"
		"midtop_vent21": Global.vent1Pos = "midtop_vent31"
		"midtop_vent31":
			if current_path == "top": Global.vent1Pos = "top_vent11"
			else: Global.vent1Pos = "mid_vent11"
		"top_vent11": Global.vent1Pos = "top_vent21"
		"top_vent21": Global.vent1Pos = "top_vent31"
		"top_vent31": Global.vent1Pos = "top_vent41"
		"top_vent41": Global.vent1Pos = "office"
		"mid_vent11": Global.vent1Pos = "mid_vent21"
		"mid_vent21": Global.vent1Pos = "mid_vent31"
		"mid_vent31": Global.vent1Pos = "office"
		"bot_vent11": Global.vent1Pos = "bot_vent21"
		"bot_vent21": Global.vent1Pos = "bot_vent31"
		"bot_vent31": Global.vent1Pos = "office"
		"office":
			check_block()
			return
		_:
			Global.vent1Pos = "ventnum11"
	
	force_visible_per_position(Global.vent1Pos)
	Global.Chica_moved.emit()

func force_visible_per_position(pos: String) -> void:
	initial_hide_all()
	match pos:
		"ventnum11": if has_node("vent_1"): $vent_1.show()
		"ventnum21": if has_node("vent_2"): $vent_2.show()
		"bot_vent11": if has_node("vent_3"): $vent_3.show()
		"bot_vent21": if has_node("vent_4"): $vent_4.show()
		"bot_vent31": if has_node("vent_5"): $vent_5.show()
		"midtop_vent11": if has_node("vent_6"): $vent_6.show()
		"midtop_vent21": if has_node("vent_7"): $vent_7.show()
		"midtop_vent31": if has_node("vent_8"): $vent_8.show()
		"mid_vent11": if has_node("vent_9"): $vent_9.show()
		"mid_vent21": if has_node("vent_10"): $vent_10.show()
		"mid_vent31": if has_node("vent_11"): $vent_11.show()
		"top_vent11": if has_node("vent_12"): $vent_12.show()
		"top_vent21": if has_node("vent_13"): $vent_13.show()
		"top_vent31": if has_node("vent_14"): $vent_14.show()
		"top_vent41": if has_node("vent_15"): $vent_15.show()

func initial_hide_all() -> void:
	for child in get_children():
		if child.name.begins_with("vent_"):
			child.hide()

func check_block() -> void:
	if $timer.timeout:
		var blocked = false
		if current_path == "top" and Global.block1 == true: blocked = true
		elif current_path == "mid" and Global.block2 == true: blocked = true
		elif current_path == "bot" and Global.block3: blocked = true
		
		if blocked:
			if has_node("bonk1"):
				$bonk1.play()
			initial_hide_all()
			Global.vent2Pos = "ventnum11"
			current_path = ""
			Global.power -= 10
		else:
			do_jumpscare()

func do_jumpscare() -> void:
	if has_node("timer"): $timer.stop()
	initial_hide_all()
	Global.Chicajumpscare.emit()
