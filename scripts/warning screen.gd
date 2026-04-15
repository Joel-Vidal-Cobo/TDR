extends Label

const menu : PackedScene = preload("res://scenes/Menu.tscn")
var canSkip : bool = false

func _ready() -> void:
	$timer.connect("timeout", timerTimeout)
	$animation.connect("animation_finished", animDone)
	$animation.play("fade in")

func timerTimeout() -> void:
	$animation.play("fade out")

func animDone(animName : StringName) -> void:
	if animName == "fade in":
		canSkip = true
		$timer.start()
	if animName == "fade out":
		get_tree().change_scene_to_packed(menu)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("skip warning") and canSkip == true:
		$animation.play("fade out")
