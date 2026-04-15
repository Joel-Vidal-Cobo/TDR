extends Control

@onready var ui_labels = {
	"I": $Chars/I/Level,
	"Me": $Chars/Me/Level,
	"Myself": $Chars/Myself/Level,
	"Puppet": $Chars/Puppet/Level,
	"GoldenFreddy": $Chars/Golden/Level,
	"Chica": $Chars/Chica/Level,
	"Mines": $Chars/Mines/Level
}

func _ready() -> void:
	if has_node("MusicSelector"):
		$MusicSelector.item_selected.connect(_on_music_selected)
	update_ui()

func change_ai(character: String, amount: int) -> void:
	if Global.AI.has(character):
		Global.AI[character] = clamp(Global.AI[character] + amount, 0, 20)
		update_ui()
		play_click_sound()
func update_ui() -> void:
	for name in ui_labels:
		if ui_labels[name] != null:
			ui_labels[name].text = str(Global.AI[name])
func set_difficulty_preset(level: int) -> void:
	for character in Global.AI.keys():
		Global.AI[character] = level
	update_ui()
	play_click_sound()
func _on_music_selected(index: int) -> void:
	if index < 5:
		Global.selectedMusic = index + 1 
	else:
		Global.selectedMusic = index

func _on_i_plus_pressed(): change_ai("I", 1)
func _on_i_minus_pressed(): change_ai("I", -1)
func _on_me_plus_pressed(): change_ai("Me", 1)
func _on_me_minus_pressed(): change_ai("Me", -1)
func _on_myself_plus_pressed(): change_ai("Myself", 1)
func _on_myself_minus_pressed(): change_ai("Myself", -1)
func _on_puppet_plus_pressed(): change_ai("Puppet", 1)
func _on_puppet_minus_pressed(): change_ai("Puppet", -1)
func _on_golden_plus_pressed(): change_ai("GoldenFreddy", 1)
func _on_golden_minus_pressed(): change_ai("GoldenFreddy", -1)
func _on_chica_plus_pressed(): change_ai("Chica", 1)
func _on_chica_minus_pressed(): change_ai("Chica", -1)
func _on_mines_plus_pressed(): change_ai("Mines", 1)
func _on_mines_minus_pressed(): change_ai("Mines", -1)
func _on_difficulty_0_pressed(): set_difficulty_preset(0)
func _on_difficulty_5_pressed(): set_difficulty_preset(5)
func _on_difficulty_10_pressed(): set_difficulty_preset(10)
func _on_difficulty_15_pressed(): set_difficulty_preset(15)
func _on_difficulty_20_pressed(): set_difficulty_preset(20)

func _on_start_button_pressed() -> void:
	var scene : PackedScene = load("res://scenes/night start.tscn")
	get_tree().change_scene_to_packed(scene)
func play_click_sound():
	if has_node("ClickSound"):
		$ClickSound.play()
