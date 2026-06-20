extends Node

@export var calendar_layer : CanvasLayer
@export var mina_layer : CanvasLayer
@export var marker_sprite : Sprite2D
@export var markers : Node

@export var fade_animation : AnimationPlayer

signal power_off

var can_click_calendar := false
var can_power_off := false
var can_click_mina := false

var mina_done := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	while not Global.game_end:
		print(Global.day)
		fade_animation.play_backwards('fade')
		await fade_animation.animation_finished
		await power_off
		fade_animation.play('fade')
		await fade_animation.animation_finished
		get_tree().change_scene_to_file("res://scenes/main.tscn")
		if Global.day == 10:
			Global.game_end = true
		break
		
	#for marker in markers.get_children():
		#await Global.next_day
		#marker_sprite.global_position = marker.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	marker_sprite.global_position = markers.get_child(Global.day - 1 ).global_position
	if can_click_calendar:
		if Input.is_action_just_pressed("left_click"):
			if calendar_layer.visible:
				calendar_layer.visible = false
				calendar_layer.layer = 1
			else: 
				calendar_layer.visible = true
				calendar_layer.layer = 2
		
	if can_click_mina and not mina_done:
		if Input.is_action_just_pressed("left_click"):
			DialogueManager.show_dialogue_balloon(load("res://addons/dialogue_manager/dialogue_scripts/mina_autumn.dialogue"))
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
