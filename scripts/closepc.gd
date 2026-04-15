extends Area2D

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pc") and Global.camUp == false and Global.pcUp == true and Global.active == true:
		_close_pc()
func _close_pc():
	Global.pcUp = !Global.pcUp
	$"close".play()
	if Global.pcUp == false:
		$"../behind".visible = true
		$"../nose honk".visible = true
		$"../blind".visible = true
		$"../screen".visible = false
		$"../closepc".visible = false
		$"../pc".visible = true
		$"../GUI/camera detection".visible = true
		$"../GUI/camera arrow".visible = true
		$"../Minesweeper".hide()
		Global.usage -= 1
		Global.active = false
		$"../office".frame = 17
		$"../office".play_backwards("default")
		while $"../office".frame > 13:
			await get_tree().process_frame
		$"../office".stop()
		if Global.blindDown == true:
			$"../office".frame = 13
		else:
			$"../office".frame = 0
func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("guiClick") and Global.camUp == false:
		_close_pc()
