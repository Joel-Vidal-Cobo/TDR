extends Label

func _ready() -> void:
	mouse_entered.connect(mouseEntered)
	SaveData.load_game()
	if Global.night_reached >= 6:
		$"../sixth night".visible = true
	if Global.night_reached >= 7:
		$"../custom night".visible = true
		Global.custom = true
	$"../newspaper/animation".animation_finished.connect(newspaperDone)
func _on_Button_mouse_exited():
	$"../arrow".visible = false
	$"../label night".visible = false

func mouseEntered() -> void:
	if get_tree().paused == false:
		$"../arrow".visible = true
		if not $"../arrow".position.y == position.y:
			$"../select".play()
		$"../arrow".position.y = position.y
		if name == "continue":
			$"../label night".visible = true
		if name != "continue":
			$"../label night".visible = false

func _gui_input(event : InputEvent) -> void:
	if event.is_action_pressed("guiClick"):
		if name == "new game":
			get_tree().paused = true
			Global.night = 1
			SaveData.save_game()
			SaveData.load_game()
			$"../newspaper".visible = true
			$"../newspaper/animation".play("show newspaper")
		if name == "continue":
			if Global.night >= 5:
				Global.night = 5
			SaveData.save_game()
			SaveData.load_game()
			var scene : PackedScene = load("res://scenes/night start.tscn")
			get_tree().change_scene_to_packed(scene)
		if name == "sixth night":
			if Global.night >= 6:
				Global.night = 6
			SaveData.save_game()
			SaveData.load_game()
			var scene : PackedScene = load("res://scenes/night start.tscn")
			get_tree().change_scene_to_packed(scene)
		if name == "custom night":
			$"../../GUI".visible = false
			$"../../scan line".visible = false
			$"../../divided static".visible = false
			$"../../static".visible = false
			$"../../recreativa".visible = false
			$"../../CustomNight".visible = true
func newspaperDone(_animName : StringName) -> void:
	if name == "new game":
		get_tree().paused = false
		var scene : PackedScene = load("res://scenes/night start.tscn")
		get_tree().change_scene_to_packed(scene)
