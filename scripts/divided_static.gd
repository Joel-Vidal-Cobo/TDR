extends AnimatedSprite2D

func _ready() -> void:
	$rest.connect("timeout", restTimeout)
	$activar.connect("timeout", activarTimeout)
	restStart()

func restTimeout() -> void:
	visible = true
	activarStart()

func activarTimeout() -> void:
	visible = false
	restStart()

func restStart() -> void:
	$rest.wait_time = randf_range(1.0, 3.0)
	$rest.start()

func activarStart() -> void:
	$activar.wait_time = randf_range(0.1, 0.4)
	$activar.start()
