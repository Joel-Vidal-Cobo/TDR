extends TileMapLayer

@onready var bombs_left = $"bombs"

const CELL_ROWS := 30
const CELL_COLUMNS := 16

var MINE_COUNT = 20 + (Global.AI["Mines"])*4
var game_ended := false
var cells : Array[int] = []
var last_move : Array[Vector2i] = []
var lives := 3

func _ready() -> void:
	MINE_COUNT = 20 + (Global.AI["Mines"])*4
	new_game()
	Global.playbomb = false
func new_game() -> void:
	game_ended = false
	lives = 3
	cells.clear()
	cells.resize(CELL_ROWS * CELL_COLUMNS)
	cells.fill(-1)
	
	clear()
	for y in range(CELL_COLUMNS):
		for x in range(CELL_ROWS):
			set_cell(Vector2i(x, y), 0, Vector2i(0, 0))
	_mines()
func _ammount_lives() -> void:
	if lives == 3:
		$Live.visible = true
		$Live2.visible = true
		$Live3.visible = true
	if lives == 2:
		$Live.visible = true
		$Live2.visible = true
		$Live3.visible = false
	if lives == 1:
		$Live.visible = true
		$Live2.visible = false
		$Live3.visible = false
	if lives == 0:
		$Live.visible = false
		$Live2.visible = false
		$Live3.visible = false

func set_up_mines(avoid : Vector2i) -> void:
	for i in range(MINE_COUNT):
		cells[i] = 0
	
	var safe_zone = get_surrounding_indices(avoid)
	safe_zone.append(get_cell_index(avoid))
	
	cells.shuffle()
	
	while cells[get_cell_index(avoid)] == 0:
		cells.shuffle()
	
	for y in range(CELL_COLUMNS):
		for x in range(CELL_ROWS):
			var current_pos = Vector2i(x, y)
			var idx = get_cell_index(current_pos)
			
			if cells[idx] != 0:
				var mine_count := 0
	
				for neighbor_idx in get_surrounding_indices(current_pos):
					if cells[neighbor_idx] == 0:
						mine_count += 1
				
				if mine_count > 0:
					cells[idx] = mine_count

func _input(event : InputEvent) -> void:
	if game_ended: return
	if not Global.playbomb: return
	if check_win(): 
		game_ended = true
		Global.usage -= 1
		return

	if event.is_action_pressed("reveal"):
		var cell_at_mouse : Vector2i = local_to_map(get_local_mouse_position())
		if get_cell_index(cell_at_mouse) == -1: return
		
		if get_cell_atlas_coords(cell_at_mouse) != Vector2i(0, 0):
			return
		
		if not cells.has(0):
			set_up_mines(cell_at_mouse)
		
		if get_cell_atlas_coords(cell_at_mouse) != Vector2i(1, 0):
			last_move = []
			reveal_cell(cell_at_mouse)
			
			if cells[get_cell_index(cell_at_mouse)] == 0:
				lives -= 1
				Global.usage += 1
				_mines()
				_ammount_lives()
				if lives == 0:
					game_ended = true
					reveal_all_mines(cell_at_mouse)
	
	if event.is_action_pressed("flag"):
		var cell_at_mouse : Vector2i = local_to_map(get_local_mouse_position())
		if get_cell_index(cell_at_mouse) == -1: return
		
		var current_atlas = get_cell_atlas_coords(cell_at_mouse)
		if current_atlas == Vector2i(0, 0):
			set_cell(cell_at_mouse, 0, Vector2i(1, 0))
		elif current_atlas == Vector2i(1, 0):
			set_cell(cell_at_mouse, 0, Vector2i(0, 0))
		_mines()

func reveal_cell(coords : Vector2i) -> void:
	var idx = get_cell_index(coords)
	if idx == -1: return
	
	if get_cell_atlas_coords(coords) != Vector2i(0, 0) and get_cell_atlas_coords(coords) != Vector2i(1, 0):
		return
	
	var atlas_pos : Vector2i
	match cells[idx]:
		-1: atlas_pos = Vector2i(3, 0)
		0:  atlas_pos = Vector2i(0, 3) 
		1:  atlas_pos = Vector2i(0, 1)
		2:  atlas_pos = Vector2i(1, 1)
		3:  atlas_pos = Vector2i(2, 1)
		4:  atlas_pos = Vector2i(3, 1)
		5:  atlas_pos = Vector2i(0, 2)
		6:  atlas_pos = Vector2i(1, 2)
		7:  atlas_pos = Vector2i(2, 2)
		8:  atlas_pos = Vector2i(3, 2)
	
	set_cell(coords, 0, atlas_pos)
	
	if cells[idx] == -1:
		for neighbor_x in range(-1, 2):
			for neighbor_y in range(-1, 2):
				if neighbor_x == 0 and neighbor_y == 0: continue
				reveal_cell(coords + Vector2i(neighbor_x, neighbor_y))

func get_cell_index(coords : Vector2i) -> int:
	if coords.x >= 0 and coords.x < CELL_ROWS and coords.y >= 0 and coords.y < CELL_COLUMNS:
		return coords.y * CELL_ROWS + coords.x
	return -1

func get_surrounding_indices(coords : Vector2i) -> Array[int]:
	var indices : Array[int] = []
	for y in range(-1, 2):
		for x in range(-1, 2):
			if x == 0 and y == 0: continue
			var idx = get_cell_index(coords + Vector2i(x, y))
			if idx != -1:
				indices.append(idx)
	return indices

func _mines():
	var flagged = get_used_cells().filter(
		func(pos): return get_cell_atlas_coords(pos) == Vector2i(1, 0)
	).size()
	
	var remaining = MINE_COUNT - flagged + lives - 3
	
	bombs_left.bomb_value(remaining)
func reveal_all_mines(clicked_mine : Vector2i) -> void:
	for y in range(CELL_COLUMNS):
		for x in range(CELL_ROWS):
			var pos = Vector2i(x, y)
			var idx = get_cell_index(pos)
			var atlas = get_cell_atlas_coords(pos)
			
			if cells[idx] == 0:
				if pos != clicked_mine and atlas != Vector2i(1, 0):
					set_cell(pos, 0, Vector2i(2, 0))
			elif atlas == Vector2i(1, 0):
				set_cell(pos, 0, Vector2i(1, 3))
func check_win() -> bool:
	var unrevealed_count := 0
	for y in range(CELL_COLUMNS):
		for x in range(CELL_ROWS):
			var pos = Vector2i(x, y)
			var idx = get_cell_index(pos)
			var atlas = get_cell_atlas_coords(pos)
			if atlas == Vector2i(0, 0) or atlas == Vector2i(1, 0):
				if cells[idx] != 0:
					unrevealed_count += 1
	return unrevealed_count == 0
