extends Node

@export var load_button : Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if FileAccess.file_exists(Global.path):
		load_button.visible = true
	else: 
		load_button.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _new_game() -> void:
	Global.reset_save_file()
	get_tree().change_scene_to_file("res://scenes/laptop.tscn")


func _load_game() -> void:
	Global.load_game()
	
	Global.day = Global.save_dict.day
	Global.pages_done = Global.save_dict.pages_done 
	Global.lessons = Global.save_dict.lessons 
	
	Global.tutorial_done = Global.save_dict.tutorial_done
	
	
	Global.chr_one_heart = Global.save_dict.chr_one_heart
	Global.chr_two_heart = Global.save_dict.chr_two_heart
	Global.chr_three_heart =Global.save_dict.chr_three_heart
	Global.chr_four_heart = Global.save_dict.chr_four_heart
	
	Global.far_one_heart = Global.save_dict.far_one_heart
	Global.far_two_heart = Global.save_dict.far_two_heart 
	Global.far_three_heart = Global.save_dict.far_three_heart 
	Global.far_four_heart = Global.save_dict.far_four_heart
	
	Global.val_one_heart = Global.save_dict.val_one_heart 
	Global.val_two_heart = Global.save_dict.val_two_heart 
	Global.val_three_heart = Global.save_dict.val_three_heart 
	Global.val_four_heart = Global.save_dict.val_four_heart 
	
	Global.val_meter = Global.save_dict.val_meter 
	Global.chr_meter = Global.save_dict.chr_meter 
	Global.far_meter = Global.save_dict.far_meter
	Global.happiness = Global.save_dict.happiness
		
	Global.days_no_val = Global.save_dict.days_no_val 
	Global.days_no_chr = Global.save_dict.days_no_chr
	Global.days_no_far = Global.save_dict.days_no_far
		
	Global.open_up = Global.save_dict.open_up
	Global.open_up_times = Global.save_dict.open_up_times
	
	Global.game_end = Global.save_dict.game_end
	
	if Global.day == 0:
		get_tree().change_scene_to_file("res://scenes/laptop.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/main.tscn")
