extends AnimatedSprite2D

func _ready() -> void:
	$rest.connect("timeout", restTimeout)
	$activar.connect("timeout", activarTimeout)
	$fade.connect("timeout", fadeTimeout)
	restStart()

func restTimeout() -> void:
	frame = randi_range(0,2)
	activarStart()

func activarTimeout() -> void:
	frame = 0
	restStart()

func restStart() -> void:
	$rest.wait_time = randf_range(0.3, 4.0)
	$rest.start()

func activarStart() -> void:
	$activar.wait_time = randf_range(0.2, 0.7)
	$activar.start()

func fadeTimeout() -> void:
	modulate.a = randf_range(0.3, 1.0)
	$"../static".modulate.a = randf_range(0.4,0.6)
