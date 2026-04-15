extends Label

var time := 450

func _ready() -> void:
	$timer.timeout.connect(timeout)
	$timer.start()

func _process(delta: float) -> void:
	text = str(time)

func timeout() -> void:
	if time > 0:
		time -= 1
	if Global.night_progress == 6:
		$timer.stop()
