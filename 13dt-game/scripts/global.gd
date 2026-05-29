extends Node

signal next_day

signal val_chosen
signal chr_chosen
signal far_chosen

signal talk
signal learn_end

signal class_ended

var day = 0

var happiness := 0
var expression = 'happy'

var is_dragging := false

var game_end := false

var lessons := 0

var val_meter := 0
var chr_meter := 0
var far_meter := 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
