extends Node2D

var can_spawn: bool = true
var last_cam_state: bool = false

func _ready() -> void:
	last_cam_state = Global.camUp

func _process(_delta: float) -> void:
	if Global.camUp != last_cam_state:
		_on_monitor_changed()
		last_cam_state = Global.camUp

func _on_monitor_changed() -> void:
	if Global.camUp == false:
		if can_spawn:
			if randi_range(1, 40) <= Global.AI["GoldenFreddy"]:
				appear()

func appear() -> void:
	$"../GoldenFreddy".visible = true
	can_spawn = false
	
	await get_tree().create_timer(0.8).timeout
	
	if Global.camUp == false and $"../GoldenFreddy".visible == true:
		jumpscare()
	else:
		$"../GoldenFreddy".visible = false
		await get_tree().create_timer(2.0).timeout
		can_spawn = true

func jumpscare() -> void:
	$"../GoldenFreddy".visible = false
	Global.GoldenFreddyjumpscare.emit()
