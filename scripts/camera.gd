extends Camera2D

var screenWidth = ProjectSettings.get_setting("display/window/size/viewport_width")
var screenHeight = ProjectSettings.get_setting("display/window/size/viewport_height")

@export var scrollArea : int
@export var scrollSpeed : float
@export var scrollDivisions : int
@export var officeSprite : AnimatedSprite2D

var officeWidth : int
var officeHeight : int
var distance : float
var divisionSize : float
var speedMultiplier : float

func _ready() -> void:
	if scrollDivisions == 0:
		scrollDivisions = 1
		divisionSize = scrollArea / scrollDivisions
	if officeSprite:
		officeWidth = officeSprite.sprite_frames.get_frame_texture(&"default", 0).get_width() * officeSprite.scale.x
		officeHeight = officeSprite.sprite_frames.get_frame_texture(&"default", 0).get_height() * officeSprite.scale.y
		position.x = (officeWidth - screenWidth) / 2
		position.y = (officeHeight - screenHeight) / 2

func _process(delta : float) -> void:
	if get_local_mouse_position().x < scrollArea:
		distance = scrollArea - get_local_mouse_position().x
		getSpeedMultiplier()
		position.x -= (scrollSpeed * speedMultiplier) * delta
		
	if get_local_mouse_position().x > screenWidth - scrollArea:
		distance = get_local_mouse_position().x - (screenWidth - scrollArea)
		getSpeedMultiplier()
		position.x += (scrollSpeed * speedMultiplier) * delta
	if get_local_mouse_position().y < scrollArea:
		distance = scrollArea - get_local_mouse_position().y
		getSpeedMultiplier()
		position.y -= (scrollSpeed * speedMultiplier) * delta
		
	if get_local_mouse_position().y > screenHeight - scrollArea:
		distance = get_local_mouse_position().y - (screenHeight - scrollArea)
		getSpeedMultiplier()
		position.y += (scrollSpeed * speedMultiplier) * delta
	if officeSprite:
		if position.x < officeSprite.position.x:
			position.x = officeSprite.position.x
		if position.x + screenWidth > officeWidth:
			position.x = officeWidth - screenWidth
			
		if position.y < officeSprite.position.y:
			position.y = officeSprite.position.y
		if position.y + screenHeight > officeHeight:
			position.y = officeHeight - screenHeight

func getSpeedMultiplier() -> void:
	speedMultiplier = clamp(floor(distance / divisionSize) + 1, 1, scrollDivisions)
	speedMultiplier /= scrollDivisions
