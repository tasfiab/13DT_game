extends Node

signal next_day

signal friend_chosen

signal option_chosen

signal class_ended

var day = 1

var happiness := 50
var expression = 'happy'

var is_dragging := false

var game_end := false

var lessons := 0

var val_chosen := false
var chr_chosen := false
var far_chosen := false

var learn := false
var talk := false

var val_meter := 0
var chr_meter := 0
var far_meter := 0

var question_asked = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if val_meter < 0:
		val_meter = 0
	if chr_meter < 0:
		chr_meter = 0
	if far_meter < 0:
		far_meter = 0
	if happiness < 0:
		happiness = 0

func add_meter(num : int):
	if val_chosen:
		val_meter += num
		
	elif chr_chosen:
		chr_meter += num
		
	elif far_chosen:
		far_meter += num 
