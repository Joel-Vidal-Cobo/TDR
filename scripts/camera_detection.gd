extends Area2D

func _ready() -> void:
	mouse_entered.connect(mouseEntered)
	mouse_exited.connect(mouseExited)
	Global.currentCamera = "office"
	$"../panel".animation_finished.connect(panelAnimDone)
	if Global.night_progress == 6:
		Global.camUp = false
		Global.canFlip = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("camera") and Global.canFlip == true and $"../../office".frame <= 13:
		_toggle_camera()

func mouseEntered() -> void:
	if Global.canFlip:
		_toggle_camera()

func mouseExited() -> void:
	$"../camera arrow".visible = true

func _toggle_camera() -> void:
	Global.canFlip = false
	Global.camUp = !Global.camUp
	$"../camera arrow".visible = false
	
	if Global.camUp:
		$"../panel".visible = true
		$"../panel".play("default")
		$"../panel/flip up".play()
		Global.usage += 2
		Global.active = true
	else:
		$"../camera/camera/cameraPan".stop()
		$"../camera/recording".stop()
		$"../camera/static".stop()
		$"../camera/blipFlash".stop()
		$"../panel/cam sound".stop()
		$"../panel".visible = true
		$"../panel".play_backwards("default")
		$"../panel/flip down".play()
		$"../panel/flip up".stop()
		$"../camera".visible = false
		Global.usage -= 2
		Global.active = false

func panelAnimDone() -> void:
	$"../panel".visible = false
	Global.canFlip = true
	$"../camera arrow".visible = true
	if Global.camUp:
		Global.switchedCamera.emit()
		$"../panel/cam sound".play()
		$"../camera".visible = true
		$"../camera/camera/cameraPan".play("pan")
		$"../camera/recording".play("default")
		$"../camera/static".play("default")
		$"../camera/blipFlash".play("default")
		$"../camera/blipFlash".get_node("sound").play()
