extends Node

signal switchedCamera
signal Me_moved
signal Mejumpscare
signal Myself_moved
signal Myselfjumpscare
signal I_moved
signal Ijumpscare
signal Puppetjumpscare
signal GoldenFreddyjumpscare
signal Chicajumpscare
signal Chica_moved
var camUp := false
var blindDown := false
var pcUp := false
var power := 1000
var starting_power:= 1000
var usage := 1
var night := 1
var nightTime := 12
var custom := false
var night_reached = 1
var trophies = 0
var night_progress = 12
var closetPos : String = "room0"
var vent1Pos : String = "ventnum11"
var vent2Pos : String = "kitchen1"
var balconyPos : String = "balcony1"
var active := true
var doorClose := false
var monitorUp := true
var canFlip := true

var path1_2 := false
var path2_2 := false
var path3_2 := false

var path1_1 := false
var path2_1 := false
var path3_1 := false

var block1 := true
var block2 := true
var block3 := true

var playbomb := true
var currentCamera : String
var music_box_value : float
var selectedMusic : int

var AI : Dictionary = { "Me": 0 , "Myself": 0 , "I": 0 , "Puppet": 0 , "GoldenFreddy": 0, "Mines": 0, "Chica": 0}

var Me_ai : int = 0
var Myself_ai : int = 0
var i_ai : int = 0
var fred_ai : int = 0
var bon_ai : int = 0
var chic_ai : int = 0
var min_ai : int = 0

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	Me_ai = 0
	Myself_ai = 0
	i_ai = 0
	fred_ai = 0
	bon_ai = 0
	min_ai = 0
	chic_ai = 0
	setUpVars()
func setUpVars() -> void:
	SaveData.load_game()
	playbomb = false
	block1 = false
	block2 = false
	block3 = false
	canFlip = true
	pcUp = false
	monitorUp = false
	doorClose = false
	blindDown = false
	camUp = false
	active = false
	currentCamera = "living0"
	
	match night:
		1: set_ai(1, 1, 1, 1, 1, 1, 1)
		2: set_ai(4, 2, 2, 2, 2, 5, 6)
		3: set_ai(6, 6, 3, 2, 3, 8, 7)
		4: set_ai(7, 7, 5, 3, 4, 10, 9)
		5: set_ai(9, 8, 7, 6, 7, 12, 11)
		6: set_ai(10, 12, 16, 10, 13, 16, 14)
		7: set_ai(Me_ai, Myself_ai, i_ai, fred_ai, bon_ai, min_ai, chic_ai)

func set_ai(m, my, i, p, gf, mi, c):
	AI["Me"] = m
	AI["Myself"] = my
	AI["I"] = i
	AI["Puppet"] = p
	AI["GoldenFreddy"] = gf
	AI["Mines"] = mi
	AI["Chica"] = c

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			get_tree().quit()
		if event.keycode == KEY_F11:
			toggle_fullscreen()
		if event.keycode == KEY_C:
			Global.night = 7
			Global.night_reached = 7
			Global.custom = true
			SaveData.save_game()
			get_tree().reload_current_scene()
func toggle_fullscreen():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_size(Vector2i(1152, 648))
		var screen_center = DisplayServer.screen_get_size() / 2
		var window_size = DisplayServer.window_get_size() / 2
		DisplayServer.window_set_position(screen_center - window_size)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
