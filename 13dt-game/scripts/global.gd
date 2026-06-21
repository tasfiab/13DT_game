extends Node

signal next_day

signal friend_chosen

signal option_chosen

signal class_ended

const DIA_SIZE_CLASS := Vector2(521,219)
const DIA_POS_CLASS := Vector2(576,60)
const DIA_SIZE_CUTSCENE := Vector2(1151,200)
const DIA_POS_CUTSCENE := Vector2(2,396)

const RESPONSE_SIZE_CLASS := Vector2(271.5,70)
const RESPONSE_POS_CLASS := Vector2(718,261)
const RESPONSE_SIZE_CUTSCENE := Vector2(271.5,70)
const RESPONSE_POS_CUTSCENE := Vector2(80,373)

const ONE_HEART := 50
const TWO_HEARTS := 100
const THREE_HEARTS := 150
const FOUR_HEARTS := 200
const MAX_HEARTS := 250

var path := "user://data.json"

var in_class := false

var day := 0

var happiness := 50
var expression = 'normal'

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

var open_up := false
var open_up_times := 0

var save_values := [day, pages_done, lessons, val_meter, chr_meter, far_meter,
					happiness, days_no_val, days_no_chr, days_no_far, open_up_times]


var save_dict := {
		'day' : 0,
		'pages_done' : 0,
		'lessons' : 0,
		
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
