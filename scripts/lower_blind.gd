extends Area2D

func ready() -> void:
	$"../office".frame = 0
	Global.blindDown = false
func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("guiClick") and Global.camUp == false:
		_move_blinds_down()
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("blinds") and Global.camUp == false:
		_move_blinds_down()
func _move_blinds_down():
	if $"../office".frame == 0 or $"../office".frame == 13:
		Global.blindDown = !Global.blindDown
		$"blinds".play()
		if Global.blindDown == true:
			$"../office".play("default")
			while $"../office".frame < 13:
				await get_tree().process_frame
			$"../office".stop()
			$"../office".frame = 13
			Global.usage += 2
		else:
			$"../office".frame = 13
			$"../office".play_backwards("default")
			Global.usage -= 2
