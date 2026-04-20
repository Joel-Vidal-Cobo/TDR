extends Node2D

func _ready() -> void:
	
	SaveData.load_game()
	Global.setUpVars()
	$stop.visible = true
	$"office out".visible = false
	Global.Puppetjumpscare.connect(_on_puppet_jumpscare)
	Global.Ijumpscare.connect(_on_i_jumpscare)
	Global.Mejumpscare.connect(_on_me_jumpscare)
	Global.Myselfjumpscare.connect(_on_myself_jumpscare)
	Global.GoldenFreddyjumpscare.connect(_on_golden_jumpscare)
	Global.Chicajumpscare.connect(_on_chica_jumpscare)
	if has_node("piano"):
		$piano.finished.connect(_on_piano_finished)
	match Global.night:
		1: Global.set_ai(1, 1, 1, 1, 1, 1, 1)
		2: Global.set_ai(4, 2, 2, 2, 2, 5, 6)
		3: Global.set_ai(6, 6, 3, 2, 3, 8, 7)
		4: Global.set_ai(7, 7, 5, 3, 4, 10, 9)
		5: Global.set_ai(9, 8, 7, 6, 7, 12, 11)
		6: Global.set_ai(10, 12, 16, 10, 13, 16, 14)
		7: Global.set_ai(Global.AI["Me"],Global.AI["Myself"],Global.AI["I"],Global.AI["Puppet"],Global.AI["GoldenFreddy"],Global.AI["Mines"],Global.AI["Chica"],)
	play_night_music()
	play_call_night()
	
func _process(_delta: float) -> void:
	update_piano_volume()
	if Global.power <= 0 and Global.active == true:
		power_out_sequence()
func play_call_night():
	var phone_path = ""
	phone_path = "res://audio/calls/Night " + str(Global.night) + ".mp3"
	$phone.stream = load(phone_path)
	$phone.play()
func on_stop_call_pressed() -> void:
	$phone.stop()
	$stop.visible = false
func execute_final_jumpscare() -> void:
	if has_node("timer"): 
		$timer.stop()
	Global.Myselfjumpscare.emit()
func power_out_sequence() -> void:
	Global.active = false
	Global.usage = 0
	Global.camUp = false
	Global.power = 0
	
	if has_node("GUI/power"): 
		$GUI/power.text = str(0) + "[font_size={36}]%[/font_size]"
	if has_node("GUI/usage"): 
		$GUI/usage.frame = 0
	
	get_tree().paused = true
	
	$"office out".visible = true
	
	var to_hide = ["GUI/camera","GUI/camera arrow", "GUI/camera detection", "blind", "behind", "pc", "monitor", "GoldenFreddy"]
	for path in to_hide:
		var node = get_node_or_null(path)
		if node: node.visible = false

	if has_node("powerout"): 
		$powerout.play()
	
	await get_tree().create_timer(randf_range(2.0, 20.0)).timeout
	
	if has_node("ToreadorMusic"):
		$ToreadorMusic.play()
		await get_tree().create_timer(randf_range(5.0, 20.0)).timeout
		$ToreadorMusic.stop()
	else:
		await get_tree().create_timer(randf_range(5.0, 20.0)).timeout
	
	await get_tree().create_timer(randf_range(2.0, 20.0)).timeout
	
	execute_final_jumpscare()
func play_night_music() -> void:
	if not has_node("piano"): return
	
	var track_path = ""
	if Global.night <= 6:
		track_path = "res://audio/music/night" + str(Global.night) + ".mp3"
	else:
		var music_id = Global.selectedMusic if Global.selectedMusic > 0 else 1
		track_path = "res://audio/music/night" + str(music_id) + ".mp3"
	
	$piano.stream = load(track_path)
	$piano.play()

func _on_piano_finished() -> void:
	$piano.play()

func update_piano_volume() -> void:
	if has_node("piano"):
		$piano.volume_db = 0 if Global.currentCamera == "piano" and Global.camUp else -50
func _on_chica_jumpscare(): execute_jumpscare("Vent1")
func _on_puppet_jumpscare(): execute_jumpscare("Puppet")
func _on_i_jumpscare(): execute_jumpscare("I")
func _on_me_jumpscare(): execute_jumpscare("Me")
func _on_golden_jumpscare(): execute_jumpscare("Golden")
func _on_myself_jumpscare(): execute_jumpscare("Myself")
func execute_jumpscare(animatronic_name: String) -> void:
	get_tree().paused = true
	Global.active = false
	if has_node("piano"):
		$piano.stop()
	
	$Jumpscare.visible = true
	$Jumpscare/Jumpscare1.visible = false
	$Jumpscare/Jumpscare2.visible = false
	
	match animatronic_name:
		"Puppet":
			$Jumpscare/Jumpscare2.visible = true
			$Jumpscare/Jumpscare2.play("Puppet")
			$Jumpscare/scare1.play()
		"I", "Me", "Myself", "Vent1":
			$Jumpscare/Jumpscare1.visible = true
			$Jumpscare/Jumpscare1.play(animatronic_name)
			$Jumpscare/scare2.play()
		"Golden":
			$Jumpscare/Jumpscare2.visible = true
			$Jumpscare/Jumpscare2.play("Golden")
			$Jumpscare/scare1.play()

	await get_tree().create_timer(3.5).timeout
	
	$Jumpscare.visible = false
	if has_node("gameover"):
		$gameover.visible = true
		await get_tree().create_timer(5.0).timeout
		get_tree().change_scene_to_file("res://scenes/Menu.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/Menu.tscn")
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_P:
				Global.power = -1
				power_out_sequence()
