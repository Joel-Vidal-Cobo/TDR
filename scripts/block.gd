extends Area2D

func _on_input_event(_viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("guiClick"):
		match shape_idx:
			0:
				_block_left()
				if Global.block1 == true:
					$"Block1".visible = true
					Global.usage += 1
				else:
					Global.usage -= 1
					$"Block1".visible = false
			1:
				_block_right()
				if Global.block2 == true:
					$"Block2".visible = true
					Global.usage += 1
				else:
					Global.usage -= 1
					$"Block2".visible = false
			2:
				_block_up()
				if Global.block3 == true:
					$"Block3".visible = true
					Global.usage += 1
				else:
					Global.usage -= 1
					$"Block3".visible = false

func _block_left():
	Global.block1 = !Global.block1
func _block_right():
	Global.block2 = !Global.block2
func _block_up():
	Global.block3 = !Global.block3
