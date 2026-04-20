extends TextureProgressBar

@export var base_drain_speed : float = 1.0     
@export var charge_speed : float = 5.0   
@export var office_volume : float = -30.0 
@export var music_room_volume : float = -10.0 
@export var jumpscare_chance : float = 0.1 

var is_charging := false
var jumpscare_timer := 0.0

func _ready() -> void:
	self.fill_mode = TextureProgressBar.FILL_COUNTER_CLOCKWISE
	update_max_capacity()
	step = 0.01 
	Global.music_box_value = max_value
	value = Global.music_box_value
	
	if $music.stream:
		$music.stream.loop = true
	$music.play()
	update_audio()
	
	if has_node("outside"):
		$outside.stream.loop = true
	
	if has_node("windup"):
		$windup.stream.loop = true

func update_max_capacity() -> void:
	var puppet_ai = Global.AI.get("Puppet", 0)
	var new_max = 100.0 - (puppet_ai * 3.0)
	
	if puppet_ai == 0:
		new_max = 999
	
	max_value = max(10.0, new_max)
	
	if has_node("Circle"):
		if puppet_ai > 0:
			$Circle.visible = true
		else:
			$Circle.visible = false
func _process(delta: float) -> void:
	update_max_capacity()
	
	var can_charge = is_charging and Global.camUp and Global.currentCamera == "music"
	if has_node("outside") and $outside.playing: 
		can_charge = false

	if can_charge:
		Global.music_box_value += charge_speed * delta
		if has_node("windup") and not $windup.playing:
			$windup.play()
	else:
		if Global.music_box_value > 0:
			Global.music_box_value -= base_drain_speed * delta
		
		if has_node("windup") and $windup.playing:
			$windup.stop()

	Global.music_box_value = clamp(Global.music_box_value, 0, max_value)
	value = Global.music_box_value

	if Global.music_box_value > 0:
		update_audio()
		if not $music.playing:
			$music.play()
		if has_node("outside") and $outside.playing:
			$outside.stop()
	else:
		if $music.playing:
			$music.stop()
		
		if has_node("outside") and not $outside.playing:
			$outside.play()
			
		handle_jumpscare_logic(delta)

func update_audio() -> void:
	var audio = $music
	var target_db = -45.0
	if Global.camUp:
		if Global.currentCamera == "music":
			target_db = music_room_volume
			if has_node("../musicbox"): 
				$"../musicbox".visible = true
		else:
			target_db = -35.0 
			if has_node("../musicbox"): 
				$"../musicbox".visible = false
	else:
		target_db = office_volume 
		if has_node("../musicbox"): 
			$"../musicbox".visible = false
	audio.volume_db = target_db

func handle_jumpscare_logic(delta: float) -> void:
	jumpscare_timer += delta
	if jumpscare_timer >= 0.5:
		jumpscare_timer = 0.0
		if randf() < jumpscare_chance:
			jumpscare()

func jumpscare() -> void:
	set_process(false) 
	if has_node("outside"):
		$outside.stop()
	if has_node("windup"):
		$windup.stop()
	Global.Puppetjumpscare.emit()

func _on_button_down() -> void:
	is_charging = true

func _on_button_up() -> void:
	is_charging = false
