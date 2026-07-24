extends Node

signal next_day

signal friend_chosen

signal option_chosen

signal class_ended

const DIA_SIZE_CLASS := Vector2(529,160)
const DIA_POS_CLASS := Vector2(576,87)
const DIA_SIZE_CUTSCENE := Vector2(1088,163)
const DIA_POS_CUTSCENE := Vector2(32,464)

const RESPONSE_SIZE_CLASS := Vector2(271.5,70)
const RESPONSE_POS_CLASS := Vector2(759,221)
const RESPONSE_SIZE_CUTSCENE := Vector2(271.5,70)
const RESPONSE_POS_CUTSCENE := Vector2(759,426)

const HEART_POINTS := 2

const ONE_HEART := 50
const TWO_HEARTS := 100
const THREE_HEARTS := 150
const FOUR_HEARTS := 200
const MAX_HEARTS := 250

const FINAL_DAY := 10

var path := "user://data5.json"

var in_class := false
var dia_size = DIA_SIZE_CLASS 
var dia_pos = DIA_POS_CLASS
var response_size = RESPONSE_SIZE_CLASS
var response_pos = RESPONSE_POS_CLASS

var dis_speed := 50

var day := 0

var happiness := 50
var expression = 'normal'
var expression_2 = 'normal'
var expression_3 = 'normal'

var is_dragging := false

var game_end := false

var pages_done := 0
var lessons := 0

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

var chr_one_heart := false
var chr_two_heart := false
var chr_three_heart := false
var chr_four_heart := false

var open_up := false
var open_up_times := 0

var tutorial_done := false

var hearts_up := false


var save_dict := {
		'day' : 0,
		'pages_done' : 0,
		'lessons' : 0,
		
		'tutorial_done' : false,
		
		"val_meter" : 0,
		"chr_meter" : 0,
		"far_meter" : 0,
		"happiness" : 50,
		
		'days_no_val' : 0,
		'days_no_chr' : 0,
		'days_no_far' : 0,
		
		'open_up' : false,
		'open_up_times' : 0,
		
		'game_end' : false,
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_game()

func save_game():
	var file = FileAccess.open_encrypted_with_pass(path, FileAccess.WRITE, "3ENJ6Y5Vj6c2PY")
	file.store_var(save_dict.duplicate())
	file.close()
	
func load_game():
	if FileAccess.file_exists(path):
		var file = FileAccess.open_encrypted_with_pass(path, FileAccess.READ, "3ENJ6Y5Vj6c2PY")
		var data = file.get_var()
		file.close()
		
		var save_data = data.duplicate()
		
		save_dict.day = save_data.day
		save_dict.pages_done = save_data.pages_done
		save_dict.lessons = save_data.lessons
		
		save_dict.val_meter = save_data.val_meter
		save_dict.chr_meter = save_data.chr_meter
		save_dict.far_meter = save_data.far_meter
		save_dict.happiness = save_data.happiness
		
		save_dict.days_no_val = save_data.days_no_val
		save_dict.days_no_chr = save_data.days_no_chr
		save_dict.days_no_far = save_data.days_no_far
		
		save_dict.open_up = save_data.open_up
		save_dict.open_up_times = save_data.open_up_times
		
		save_dict.game_end = save_data.game_end
	
func reset_save_file():
	if FileAccess.file_exists(path):
		var delete = DirAccess.remove_absolute(path)

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


func dialogue_meter_up(meter, num):
	meter += num
	hearts_up = true


func dialogue_meter_down(meter,num):
	meter -= num
	wrong += 1

func event():
	if Global.chr_meter > ONE_HEART and not chr_one_heart:
		const BALLOON = preload("res://addons/cs_balloon.tscn")
		DialogueManager.show_dialogue_balloon_scene(BALLOON,load("res://addons/dialogue_manager/dialogue_scripts/chr_heart_events.dialogue"))
		await DialogueManager.dialogue_ended
		chr_one_heart = true
