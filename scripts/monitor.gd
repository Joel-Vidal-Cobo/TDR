extends Area2D

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("vent") and Global.camUp == false and Global.monitorUp == false and Global.active == false:
		get_viewport().set_input_as_handled()
		_activate_monitor()
func _activate_monitor():
	if $"../office".frame == 0 or $"../office".frame == 13:
		if Global.monitorUp == false:
			$"../behind".visible = false
			$"../ambience".play()
			$"../nose honk".visible = false
			$"../blind".visible = false
			$"../vents".visible = true
			$"../closemonitor".visible = true
			$"../pc".visible = false
			$"../monitor".visible = false
			$"../GUI/camera detection".visible = false
			$"../GUI/camera arrow".visible = false
			$"../block".visible = true
			$"../IAI".visible = true
			$"../ChicaAI".visible = true
			Global.usage += 1
			Global.active = true
			Global.monitorUp = true
			Global.canFlip = false
func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("guiClick") and Global.camUp == false:
		_activate_monitor()
