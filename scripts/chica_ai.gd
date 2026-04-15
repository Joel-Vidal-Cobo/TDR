extends Node2D

@export var vent_textures_path : Dictionary = {
	"ventnum1": "vent1",
	"ventnum2": "vent2",
	"bot_vent1": "vent3",
	"bot_vent2": "vent4",
	"bot_vent3": "vent5",
	"midtop_vent1": "vent6",
	"midtop_vent2": "vent7",
	"midtop_vent3": "vent8",
	"mid_vent1": "vent9",
	"mid_vent2": "vent10",
	"mid_vent3": "vent11",
	"top_vent1": "vent12",
	"top_vent2": "vent13",
	"top_vent3": "vent14",
	"top_vent4": "vent15"
}

var current_path: String = ""

func _ready() -> void:
	hide_all_vents()
	if has_node("timer"):
		$timer.timeout.connect(_on_timer_timeout)
		$timer.start()

func _on_timer_timeout() -> void:
	if randi_range(1, 40) <= Global.AI["Chica"]:
		move()

func move() -> void:
	var old_pos = Global.vent1Pos
	
	match old_pos:
		"ventnum1": 
			Global.vent1Pos = "ventnum2"
		"ventnum2":
			var r = randi_range(1, 3)
			if r == 1:
				current_path = "top"
				Global.vent1Pos = "midtop_vent1"
			elif r == 2:
				current_path = "bot"
				Global.vent1Pos = "bot_vent1"
			else:
				current_path = "mid"
				Global.vent1Pos = "midtop_vent1"
		
		"midtop_vent1": Global.vent1Pos = "midtop_vent2"
		"midtop_vent2": Global.vent1Pos = "midtop_vent3"
		"midtop_vent3":
			if current_path == "top":
				Global.vent1Pos = "top_vent1"
			else:
				Global.vent1Pos = "mid_vent1"
		
		"top_vent1": Global.vent1Pos = "top_vent2"
		"top_vent2": Global.vent1Pos = "top_vent3"
		"top_vent3": Global.vent1Pos = "top_vent4"
		"top_vent4": Global.vent1Pos = "office"
		
		"mid_vent1": Global.vent1Pos = "mid_vent2"
		"mid_vent2": Global.vent1Pos = "mid_vent3"
		"mid_vent3": Global.vent1Pos = "office"
		
		"bot_vent1": Global.vent1Pos = "bot_vent2"
		"bot_vent2": Global.vent1Pos = "bot_vent3"
		"bot_vent3": Global.vent1Pos = "office"
		
		"office":
			check_block()
			return

	update_vent_visuals(old_pos)
	
	if old_pos != Global.vent1Pos:
		Global.I_moved.emit()

func update_vent_visuals(old_pos: String) -> void:
	if vent_textures_path.has(old_pos):
		var old_node = vent_textures_path[old_pos]
		if has_node(old_node):
			get_node(old_node).visible = false
			
	if vent_textures_path.has(Global.vent1Pos):
		var new_node = vent_textures_path[Global.vent1Pos]
		if has_node(new_node):
			get_node(new_node).visible = true

func hide_all_vents() -> void:
	for node_name in vent_textures_path.values():
		if has_node(node_name):
			get_node(node_name).visible = false

func check_block() -> void:
	var blocked = false
	if current_path == "top" and Global.block1: blocked = true
	elif current_path == "mid" and Global.block2: blocked = true
	elif current_path == "bot" and Global.block3: blocked = true
	
	if blocked:
		if has_node("bonk"):
			$bonk.play()
		hide_all_vents()
		Global.vent1Pos = "ventnum1"
		current_path = ""
		Global.power -= 10
	else:
		jumpscare()

func jumpscare():
	if has_node("timer"):
		$timer.stop()
	hide_all_vents()
	Global.Chicajumpscare.emit()
