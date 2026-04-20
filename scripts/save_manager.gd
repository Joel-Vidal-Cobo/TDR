extends Node

const SAVE_PATH = "user://savegame.bin"
const SETTINGS_PASS = "i{l7!UUb@sFCY837YeK7x%nEX"
var delete_timer := 0.0
const DELETE_THRESHOLD := 5.0
var config = ConfigFile.new()

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_DELETE):
		delete_timer += delta
		if delete_timer >= DELETE_THRESHOLD:
			delete_save_data()
			SaveData.save_game()
	else:
		delete_timer = 0.0

func save_game():
	config.set_value("Progress", "night", Global.night)
	config.set_value("Progress", "night_won", Global.night_reached)
	config.set_value("Progress", "trophies", Global.trophies)
	config.set_value("Progress", "timer_start", Global.nightTime)
	config.save_encrypted_pass(SAVE_PATH, SETTINGS_PASS)

func load_game():
	var err = config.load_encrypted_pass(SAVE_PATH, SETTINGS_PASS)
	if err == OK:
		Global.night = config.get_value("Progress", "night", 1)
		Global.night_reached = config.get_value("Progress", "night_won", 1)
		Global.trophies = config.get_value("Progress", "trophies", 0)
		Global.nightTime = config.get_value("Progress", "timer_start", 12)

func delete_save_data() -> void:
	delete_timer = 0.0
	
	if FileAccess.file_exists(SAVE_PATH):
		DirAccess.remove_absolute(SAVE_PATH)
	
	Global.night = 1
	Global.night_reached = 1
	Global.trophies = 0
	Global.nightTime = 12
	
	get_tree().reload_current_scene()
