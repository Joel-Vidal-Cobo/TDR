extends AnimatedSprite2D

@onready var blipFlash : AnimatedSprite2D = $"../blipFlash"
@onready var detector : Area2D = $detector
@export var camera : String

func _ready() -> void:
	detector.input_event.connect(onInputEvent)
	Global.switchedCamera.connect(_on_switched_Camera)
func onInputEvent(_viewport : Node, event : InputEvent, _shape_idx : int) -> void:
	if event.is_action_pressed("guiClick"):
		Global.currentCamera = camera
		Global.switchedCamera.emit()
		blipFlash.play("default")
		blipFlash.get_node("sound").play()
		play("pressed")

func _on_switched_Camera() -> void:
	if Global.currentCamera == camera:
		play("pressed")
	else:
		play("unpressed")
