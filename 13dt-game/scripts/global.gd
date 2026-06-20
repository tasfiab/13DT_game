extends Node

signal next_day

signal friend_chosen

signal option_chosen

signal class_ended

const DIO_SIZE_CLASS := Vector2(521,219)
const DIO_POS_CLASS := Vector2(576,60)
const DIO_SIZE_CUTSCENE := Vector2(1151,200)
const DIO_POS_CUTSCENE := Vector2(2,396)

const RESPONSE_SIZE_CLASS := Vector2(271.5,70)
const RESPONSE_POS_CLASS := Vector2(718,261)
const RESPONSE_SIZE_CUTSCENE := Vector2(271.5,70)
const RESPONSE_POS_CUTSCENE := Vector2(80,373)

const ONE_HEART := 50
const TWO_HEARTS := 100
const THREE_HEARTS := 150
const FOUR_HEARTS := 200
const MAX_HEARTS := 250

var in_class := false

var day := 0

var happiness := 50
var expression = 'normal'

var is_dragging := false

var game_end := false

var pages_done := 0
var lessons := 1

var val_chosen := false
var chr_chosen := false
var far_chosen := false

var learn := false
var talk := false

var val_meter := 0
var chr_meter := 0
var far_meter := 0

var days_no_val := 0
var days_no_chr := 0
var days_no_far := 0

var wrong := 0

var question_asked := true

var open_up := false
var open_up_times := 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if val_meter < 0:
		val_meter = 0
	if val_meter > MAX_HEARTS:
		val_meter = MAX_HEARTS
	
	if chr_meter < 0:
		chr_meter = 0
	if chr_meter > MAX_HEARTS:
		chr_meter = MAX_HEARTS
		
	if far_meter < 0:
		far_meter = 0
	if far_meter > MAX_HEARTS:
		far_meter = MAX_HEARTS
		
	if happiness < 0:
		happiness = 0
	if happiness > 100:
		happiness = 100

func add_meter(num : int):
	if val_chosen:
		val_meter += num
		print(val_meter)
		
	elif chr_chosen:
		chr_meter += num
		print(chr_meter)
		
	elif far_chosen:
		far_meter += num 
		print(far_meter)
