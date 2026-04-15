extends Area2D

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("vent") and not Global.camUp and Global.monitorUp and Global.active:
		_close_monitor()
		get_viewport().set_input_as_handled()
func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("guiClick") and not Global.camUp:
		_close_monitor()

func _close_monitor():
	if $"../office".frame == 0 or $"../office".frame == 13:
		Global.monitorUp = false
		Global.active = false
		Global.playbomb = false
		Global.canFlip = true
		Global.usage -= 1
		$"../ambience".stop()
		$"close".play()
		$"../vents".visible = false
		$"../closemonitor".visible = false
		$"../behind".visible = true
		$"../nose honk".visible = true
		$"../blind".visible = true
		$"../pc".visible = true
		$"../monitor".visible = true
		$"../GUI/camera detection".visible = true
		$"../GUI/camera arrow".visible = true
		$"../block".visible = false
		$"../IAI".visible = false
		$"../ChicaAI".visible = false
