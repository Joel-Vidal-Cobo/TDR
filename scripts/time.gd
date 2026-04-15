extends Label

@export var initialWait : int = 100
@export var after12Wait : int = 70

func _ready() -> void:
	get_tree().paused = false
	$timer.timeout.connect(timeout)
	$timer.wait_time = initialWait
	$timer.start()
	Global.night_progress = Global.nightTime

func timeout() -> void:
	$timer.wait_time = after12Wait
	$timer.start()
	Global.night_progress += 1
	if Global.night_progress > 12:
		Global.night_progress = 1
	text = str(Global.night_progress) + " AM"
	if Global.night_progress == 6:
		$timer.stop()
		Global.night_progress == 12
		get_tree().paused = true
		var win_screen = get_tree().current_scene.get_node("sixAm")
		win_screen.show()
		win_screen._ready()
