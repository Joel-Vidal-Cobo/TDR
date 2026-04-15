extends AnimatedSprite2D

func _ready() -> void:
	Global.usage = 1
func _process(delta: float) -> void:
	frame = Global.usage
