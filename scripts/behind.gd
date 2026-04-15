extends Area2D

func ready() -> void:
	$"../office".frame = 0
	Global.doorClose = false
func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("guiClick") and Global.camUp == false:
		_move_behind()
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("behind") and Global.camUp == false and Global.active == false:
		_move_behind()
func _move_behind():
	if $"../office".frame == 0 or $"../office".frame == 13 or $"../office".frame == 18 or $"../office".frame == 24:
		Global.doorClose = !Global.doorClose
		$"running".play()
		if Global.doorClose == true:
			Global.canFlip = false
			Global.usage += 2
			$"../nose honk".visible = false
			$"../blind".visible = false
			$"../pc".visible = false
			$"../GUI/camera detection".visible = false
			$"../GUI/camera arrow".visible = false
			$"../office".frame = 18
			$"../office".play("default")
			while $"../office".frame < 23:
				await get_tree().process_frame
			$"../office".stop()
			$"running".stop()
			$"../office".frame = 24
		else:
			$"../office".frame = 24
			$"../office".play_backwards("default")
			while $"../office".frame > 17:
				await get_tree().process_frame
			$"../office".stop()
			Global.canFlip = true
			$"../nose honk".visible = true
			$"../blind".visible = true
			$"../pc".visible = true
			$"../GUI/camera detection".visible = true
			$"../GUI/camera arrow".visible = true
			Global.usage -= 2
			$"running".stop()
			if Global.blindDown:
				$"../office".frame = 13
			else:
				$"../office".frame = 0
