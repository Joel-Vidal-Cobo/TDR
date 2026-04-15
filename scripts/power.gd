extends RichTextLabel


func _ready() -> void:
	$timer.timeout.connect(timeout)
	$timer2.timeout.connect(timeout2)
	Global.power = Global.starting_power
	match Global.night:
		1:
			$timer2.wait_time = 7.0
		2:
			$timer2.wait_time = 6.0
		3:
			$timer2.wait_time = 5.0
		4:
			$timer2.wait_time = 4.0
		_:
			$timer2.wait_time = 3.0

	$timer2.start()
func _process(delta: float) -> void:
	text = str(Global.power / 10) + "[font_size={36}]%[/font_size]"

func timeout() -> void:
	if Global.power <= 0:
		$timer.start()
		$timer2.stop()
	if Global.night_progress == 6:
		$timer.stop()
func timeout2() -> void:
	if Global.power > 0:
		Global.power -= Global.usage
	if Global.night_progress == 6:
		$timer2.stop()
