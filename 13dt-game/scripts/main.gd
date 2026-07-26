extends Node

signal minigame_ended

@export var choosing_friends_layer : CanvasLayer

@export var learn_timer : Timer
@export var learn_time : Label

@export var important : Label
@export var distraction : Label
@export var target_node : Node

@export var text_box : Panel
@export var ans_button : VBoxContainer
@export var question : Label

@export var mina_button : Button

@export var friend_text_box : Panel
@export var friend_text : Label

@export var cam : Camera2D

@export var q_time : Label
@export var q_timer : Timer

@export var wrong_label : Label
@export var wrong_progress_bar : ProgressBar

@export var ui : Control 

@export var fade_animation : AnimationPlayer

@export var end_screen : CanvasLayer

@export var tutorial : Node2D

@export var chr_bg : Sprite2D
@export var val_bg : Sprite2D
@export var far_bg : Sprite2D 

const INIT_POS := Vector2(0,0)
const DOWN_POS := Vector2(0,504)
const LEFT_POS := Vector2(-1152,0)

const DIS_SCENE := preload("res://scenes/distraction.tscn")
const IMP_SCENE := preload("res://scenes/important_info.tscn")

const START := "Violet! What did you get for "
const Q := "Q"
const RIGHT := "Right answer!"
const WRONG := "Not Quite..."

const FRIEND_TEXT := "I think it's "

var dis_speed := 50
var imp_speed := 1
var time := 0.0
var radius := 1

var draggable := false
var offset : Vector2

var learn_start := false
var learn_time_left := 30
var question_asked := false

var friend_ans : String

var answered = false

var topic : int
var q_num : int
var right_ans := false

var q_time_left = 10

var topics = ['Algebra ', 'Trig ', 'Graphs ', 'Calc ', 'Stats ',
				'Language Features ', 'Essays ', 'Grammar ', 'Themes ',
				'Chemistry ', 'Physics ', 'Biology ']

var ans = {
	"Algebra " : {
		1 : "a",
		2 : "b",
		3 : "a",
	},
	"Trig " : {
		1 : "c",
		2 : "d",
		3 : "a",
	},
	"Graphs " : {
		1 : "d",
		2 : "a",
		3 : "b",
	},
	"Calc " : {
		1 : "b",
		2 : "b",
		3 : "c",
	},
	"Stats " : {
		1 : "b",
		2 : "a",
		3 : "b",
	},
	"Language Features " : {
		1 : "d",
		2 : "c",
		3 : "c",
	},
	"Essays " : {
		1 : "d",
		2 : "d",
		3 : "b",
	},
	"Grammar " : {
		1 : "c",
		2 : "d",
		3 : "d",
	},
	"Themes " : {
		1 : "a",
		2 : "a",
		3 : "a",
	},
	"Chemistry " : {
		1 : "c",
		2 : "a",
		3 : "b",
	},
	"Physics " : {
		1 : "a",
		2 : "b",
		3 : "b",
	},
	"Biology " : {
		1 : "c",
		2 : "a",
		3 : "d",
	},
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mina_button.visible = false
	cam.position = INIT_POS
	text_box.visible = false
	
	if Global.happiness <= 0:
		end_screen.visible = true
		Global.reset_save_file()

	if Global.day == Global.FINAL_DAY:
		end_screen.visible = true
		Global.reset_save_file()
	
	while not Global.day == Global.FINAL_DAY:
		#const BALLOON = preload("res://addons/cs_balloon.tscn")
		#DialogueManager.show_dialogue_balloon_scene(BALLOON, load("res://addons/dialogue_manager/dialogue_scripts/chr_heart_events.dialogue"))
		#await DialogueManager.dialogue_ended
		Global.in_class = true
		#wrong_label.visible = false
		if Global.day == 0:
			Global.happiness = 50
		
		elif Global.day % 5 == 0:
			Global.open_up = false
			Global.happiness = 0 + round(Global.happiness/3)
		
		else:
			Global.happiness -= 10
			
		if Global.day % 3 == 0:
			Global.lessons += 1
		
		friend_text_box.visible = false
		q_time.visible = false
		q_time_left = 10
		learn_time.visible = false
		learn_time_left = 30
		fade_animation.play_backwards('fade')
		await fade_animation.animation_finished
		choosing_friends_layer.show()
		await Global.option_chosen
		choosing_friends_layer.hide()
		if Global.talk:
			print("talk")
			if Global.val_chosen:
				val_bg.visible = true
				Global.val_meter += 5
				chr_bg.visible = false
				far_bg.visible = false
			elif Global.chr_chosen:
				val_bg.visible = false
				chr_bg.visible = true
				far_bg.visible = false
			else:
				val_bg.visible = false
				chr_bg.visible = false
				far_bg.visible = true
				Global.far_meter += 3
			
			var tween : Tween = create_tween()
			tween.tween_property(cam, "global_position", LEFT_POS, 0.3)
			await tween.finished
			if Global.val_chosen:
				DialogueManager.show_dialogue_balloon(load("res://addons/dialogue_manager/dialogue_scripts/val_class.dialogue"))
				await DialogueManager.dialogue_ended
			elif Global.chr_chosen:
				DialogueManager.show_dialogue_balloon(load("res://addons/dialogue_manager/dialogue_scripts/chr_class.dialogue"))
				await DialogueManager.dialogue_ended
			elif Global.far_chosen:
				DialogueManager.show_dialogue_balloon(load("res://addons/dialogue_manager/dialogue_scripts/far_class.dialogue"))
				await DialogueManager.dialogue_ended
			if Global.wrong >= 3:
				Global.happiness -= 20
			Global.wrong = 0
			var tween_back : Tween = create_tween()
			tween_back.tween_property(cam, "global_position", INIT_POS, 0.2)
			await tween_back.finished
			Global.talk = false

		if Global.learn:
			if Global.pages_done < Global.lessons:
				Global.pages_done += 1
			print("learn")
			learn_start = true
			learn_timer.start()
			learn_time.visible = true
			await get_tree().create_timer(30).timeout
			learn_start = false
			Global.dis_speed = 50
			Global.learn = false
		
		var chance = randi_range(1,3)
		#var chance = 1
		
		if chance == 1 and Global.day > 0:
			print("your here :)")
			question_asked = true
			text_box.visible = true
			ans_button.visible = true
			mina_button.visible = true
			topic = randi_range(0, (Global.lessons - 1))
			q_num = randi_range(1,3)
			question.text = START + topics[topic] + Q + str(q_num)
			var friend_chance : int
			
			if Global.val_chosen:
				friend_chance = randi_range(1,4)
				
			elif Global.chr_chosen:
				friend_chance = randi_range(1,2)
			
			else:
				friend_chance = randi_range(1,3)
			if friend_chance == 1:
				print("yay")
				friend_ans = str(ans[topics[topic]][q_num])
			else:
				friend_ans = char(randi_range(97,100))
			
			friend_text.text = FRIEND_TEXT + friend_ans 
			friend_text_box.visible = true
			
			if Global.tutorial_done:
				q_time.visible = true
				q_timer.start()
			else:
				tutorial.visible = true
				
			await minigame_ended
			Global.tutorial_done = true
			tutorial.visible = false
			var tween : Tween = create_tween()
			tween.tween_property(cam, "global_position", INIT_POS, 0.2)
			if answered:
				ans_button.visible = false
				mina_button.visible = false
				if right_ans:
					question.text = RIGHT
					await get_tree().create_timer(5).timeout
				else:
					question.text = WRONG
					await get_tree().create_timer(5).timeout
					
			
			else:
				ans_button.visible = false
				mina_button.visible = false
				question.text = "never mind"
				await get_tree().create_timer(5).timeout
			
		fade_animation.play('fade')
		await fade_animation.animation_finished
		Global.event()
		Global.day += 1
		get_tree().change_scene_to_file("res://scenes/laptop.tscn")
		Global.in_class = false
		break
		
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.talk:
		#wrong_label.text = "wrong: " + str(Global.wrong) + "/3"
		wrong_progress_bar.visible = true
		wrong_progress_bar.value = Global.wrong
		#wrong_label.visible = true
	else: 
		#wrong_label.visible = false
		wrong_progress_bar.visible = false
		wrong_progress_bar.value = 0
		
	q_time.text = str(q_time_left)
	if learn_start:
		time += delta * imp_speed
		
		if important != null:
			important.visible = true
			important.global_position = important.global_position.move_toward(target_node.global_position, dis_speed * delta)
			#important.global_position = Vector2(important.global_position.x + sin(time) * radius, 
												#important.global_position.y + cos(time) * 
												#radius)
		
		if distraction != null:
			distraction.visible = true
			distraction.global_position = distraction.global_position.move_toward(target_node.global_position, dis_speed * delta)
	
	else: 
		if important != null:
			important.visible = false
		
		if distraction != null:
			distraction.visible = false
		
	if question_asked:
		const DOWN = "ui_down"
		const LEFT = "ui_left"
		const UP = "ui_up"
		const RIGHT = "ui_right"
		
		if Input.is_action_just_pressed(DOWN):
			var tween : Tween = create_tween()
			if cam.global_position == LEFT_POS:
				tween.tween_property(cam, "global_position", INIT_POS, 0.2)
			tween.tween_property(cam, "global_position", DOWN_POS, 0.2)
		
		elif Input.is_action_just_pressed(LEFT) and not cam.global_position == DOWN_POS:
			var tween : Tween = create_tween()
			tween.tween_property(cam, "global_position", LEFT_POS, 0.2)
		
		elif Input.is_action_just_pressed(LEFT) and cam.global_position == DOWN_POS:
			var tween : Tween = create_tween()
			tween.tween_property(cam, "global_position", INIT_POS, 0.2)
			tween.tween_property(cam, "global_position", LEFT_POS, 0.2)
			
		elif Input.is_action_just_pressed(RIGHT) or Input.is_action_just_pressed(UP):
			var tween : Tween = create_tween()
			tween.tween_property(cam, "global_position", INIT_POS, 0.2)

func _on_head_entered(area: Area2D) -> void:
	if area.has_meta('distraction'):
		Global.happiness -= 5
		print(Global.happiness)
		_new_dis()

	elif area.has_meta('important'):
		Global.happiness += 2
		print(Global.happiness)
		important.queue_free()
		important = null
		await get_tree().create_timer(1).timeout
		var imp_instance = IMP_SCENE.instantiate()
		imp_instance.global_position = Vector2(randi_range(100,1000),randi_range(1,500))
		add_child(imp_instance)
		important = imp_instance



func _boundary_entered(area: Area2D) -> void:
	if area.has_meta('distraction'):
		_new_dis()


func _new_dis():
	distraction.queue_free()
	Global.dis_speed = Global.dis_speed * 2
	await get_tree().create_timer(0.2).timeout
	var instance = DIS_SCENE.instantiate()
	instance.global_position = Vector2(randi_range(100,1000),randi_range(1, 500))
	add_child(instance)
	distraction = instance


func _a_pressed() -> void:
	ans_pressed("a")


func _b_pressed() -> void:
	ans_pressed("b")


func _c_pressed() -> void:
	ans_pressed("c")


func _d_pressed() -> void:
	ans_pressed("d")


func ans_pressed(letter : String):
	answered = true
	q_timer.stop()
	q_time.visible = false
	if ans[topics[topic]][q_num] == letter:
		print(ans[topics[topic]][q_num])
		right_ans = true
		Global.happiness += 20
	else:
		right_ans = false
		Global.happiness -= 30
		
	if friend_ans == letter:
		Global.add_meter(10)
	
	minigame_ended.emit()
	question_asked = false

func _on_timer_timeout() -> void:
	q_time_left -= 1
	if q_time_left == 0:
		minigame_ended.emit()
		q_timer.stop()
		Global.happiness -= 20
		q_time.visible = false
	else:
		q_timer.start()


func _learn_timer_timeout() -> void:
	learn_time_left -= 1
	learn_time.text = str(learn_time_left)
	if learn_time_left == 0:
		learn_timer.stop()
		learn_time.visible = false
	else:
		learn_timer.start()


func _mina_asked() -> void:
	answered = true
	right_ans = true
	minigame_ended.emit()
		
