class_name Minigame_Part
extends Node

@export var label : Label

var draggable = false
var offset : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.is_dragging = false
	
	self.mouse_entered.connect(_on_mouse_entered)
	self.mouse_exited.connect(_on_mouse_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	dragging()

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
