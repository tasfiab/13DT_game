extends Node

@export var calendar_layer : CanvasLayer
@export var mina_layer : CanvasLayer
@export var marker_sprite : Sprite2D
@export var markers : Node

@export var fade_animation : AnimationPlayer
@export var game_saved : Label

signal power_off

var can_click_calendar := false
var can_power_off := false
var can_click_mina := false

var mina_done := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	while not Global.day == Global.FINAL_DAY + 1:
		if Global.day == 0:
			mina_layer.visible = true
			DialogueManager.show_dialogue_balloon(load("res://addons/dialogue_manager/dialogue_scripts/tutorial.dialogue"))
			await DialogueManager.dialogue_ended
			fade_animation.play('fade')
			await fade_animation.animation_finished
			
		else: 
			print(Global.day)
			fade_animation.play_backwards('fade')
			await fade_animation.animation_finished
			await power_off
			fade_animation.play('fade')
			await fade_animation.animation_finished
			game_saved.visible = true
			await get_tree().create_timer(1).timeout
			game_saved.visible = false
		
		Global.save_dict.day = Global.day
		Global.save_dict.pages_done = Global.pages_done
		Global.save_dict.lessons = Global.lessons
		
		Global.save_dict.tutorial_done = Global.tutorial_done
		
		Global.save_dict.chr_one_heart = Global.chr_one_heart
		Global.save_dict.chr_two_heart = Global.chr_two_heart 
		Global.save_dict.chr_three_heart = Global.chr_three_heart
		Global.save_dict.chr_four_heart = Global.chr_four_heart

		Global.save_dict.far_one_heart = Global.far_one_heart
		Global.save_dict.far_two_heart = Global.far_two_heart
		Global.save_dict.far_three_heart = Global.far_three_heart
		Global.save_dict.far_four_heart = Global.far_four_heart
		
		Global.save_dict.val_one_heart = Global.val_one_heart
		Global.save_dict.val_two_heart = Global.val_two_heart
		Global.save_dict.val_three_heart = Global.val_three_heart
		Global.save_dict.val_four_heart = Global.val_four_heart
		
		Global.save_dict.val_meter = Global.val_meter
		Global.save_dict.chr_meter = Global.chr_meter
		Global.save_dict.far_meter = Global.far_meter
		Global.save_dict.happiness = Global.happiness
		
		Global.save_dict.days_no_val = Global.days_no_val
		Global.save_dict.days_no_chr = Global.days_no_chr
		Global.save_dict.days_no_far = Global.days_no_far
		
		Global.save_dict.open_up = Global.open_up
		Global.save_dict.open_up_times = Global.open_up_times
		
		Global.save_dict.game_end = Global.game_end
		
		
		Global.save_game()
		
			
		get_tree().change_scene_to_file("res://scenes/main.tscn")
		break
		
	#for marker in markers.get_children():
		#await Global.next_day
		#marker_sprite.global_position = marker.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	marker_sprite.global_position = markers.get_child(Global.day - 1).global_position
	if can_click_calendar:
		if Input.is_action_just_pressed("left_click"):
			if calendar_layer.visible and calendar_layer.layer > mina_layer.layer:
				calendar_layer.visible = false
				calendar_layer.layer = 1
			else: 
				calendar_layer.visible = true
				calendar_layer.layer = mina_layer.layer + 1
		
	if can_click_mina:
		if Input.is_action_just_pressed("left_click"):
			if mina_layer.visible and mina_layer.layer > calendar_layer.layer:
				mina_layer.visible = false
				mina_layer.layer = 1
			else:
				mina_layer.visible = true
				if not mina_done:
					can_click_mina = false
					DialogueManager.show_dialogue_balloon(load("res://addons/dialogue_manager/dialogue_scripts/mina_autumn.dialogue"))
				mina_layer.layer = calendar_layer.layer + 1
				mina_done = true
			
			
	if can_power_off:
		if Input.is_action_just_pressed("left_click"):
			power_off.emit()
			can_power_off = false



func _on_calendar_mouse_entered() -> void:
	can_click_calendar = true


func _on_calendar_mouse_exited() -> void:
	can_click_calendar = false


func _can_power_off() -> void:
	can_power_off = true


func _cannot_power_off() -> void:
	can_power_off = false


func _can_click_mina() -> void:
	can_click_mina = true


func _cannot_click_mina() -> void:
	can_click_mina = false


func _close() -> void:
	if calendar_layer.visible and calendar_layer.layer > mina_layer.layer:
		calendar_layer.visible = false
		calendar_layer.layer = 1
	if mina_layer.visible and mina_layer.layer > calendar_layer.layer:
		mina_layer.visible = false
		mina_layer.layer = 1
