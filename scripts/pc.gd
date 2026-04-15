extends Area2D

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pc") and Global.camUp == false and Global.pcUp == false and Global.active == false:
		_start_pc()
func _start_pc():
	if $"../office".frame == 0 or $"../office".frame == 13:
		Global.pcUp = !Global.pcUp
		$"start".play()
		if Global.pcUp == true:
			$"../office".frame = 14
			$"../office".play("default")
			while $"../office".frame < 17:
				await get_tree().process_frame
			$"../office".stop()
			$"../office".frame = 17
			$"../behind".visible = false
			$"../nose honk".visible = false
			$"../blind".visible = false
			$"../screen".visible = true
			$"../pc".visible = false
			$"../closepc".visible = true
			$"../GUI/camera detection".visible = false
			$"../GUI/camera arrow".visible = false
			$"../Minesweeper".show()
			Global.playbomb = true
			Global.active = true
			Global.usage += 1
func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("guiClick") and Global.camUp == false:
		_start_pc()
