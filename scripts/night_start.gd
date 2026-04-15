extends Control

func _ready() -> void:
	get_tree().paused = true
	$Label/animation.animation_finished.connect(fadeDone)
	$Label/animation.play("fade out")
	$clock/animation.animation_finished.connect(fadeDone)
	$clock/animation.play("fade out")
	$blip.play()
	$"blip flash".visible = true
	$"blip flash".play("default")

func fadeDone(_animName: StringName) -> void:
	
	$clock/animation.play("fade out")
	
	var scene : PackedScene = load("res://scenes/office.tscn")
	get_tree().change_scene_to_packed(scene)
