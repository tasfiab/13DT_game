class_name Minigame_Part
extends Node

@export var label : Label
@export var speed : int
@export var target_node : Area2D


var draggable = false
var offset : Vector2

func _on_mouse_entered() -> void:
	if not Global.is_dragging:
		draggable = true

func _on_mouse_exited() -> void:
	if not Global.is_dragging:
		draggable = false


func dragging() -> void:
	if draggable:
		if Input.is_action_just_pressed("left_click"):
			offset = label.get_global_mouse_position() - label.global_position 
			Global.is_dragging = true
			
		if Input.is_action_pressed('left_click'):
			label.global_position = label.get_global_mouse_position() - offset
			
		elif Input.is_action_just_released("left_click"):
			Global.is_dragging = false
