extends Node


const DIALOGUE_PATH := "res://addons/dialogue_manager/dialogue_scripts/val_class"
const DIALOGUE_END := ".dialogue"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	while not Global.game_end:
		await Global.val_chosen
		await Global.talk
		DialogueManager.show_dialogue_balloon(load(DIALOGUE_PATH + DIALOGUE_END))
		await DialogueManager.dialogue_ended
		Global.class_ended.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
