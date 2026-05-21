extends Node

@export var calendar_layer : CanvasLayer
@export var mina_layer : CanvasLayer
@export var marker_sprite : Sprite2D
@export var markers : Node

var can_click_calendar := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for marker in markers.get_children():
		await Global.next_day
		marker_sprite.global_position = marker.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if can_click_calendar:
		if Input.is_action_just_pressed("left_click"):
			if calendar_layer.visible:
				calendar_layer.visible = false
				calendar_layer.layer = 1
			else: 
				calendar_layer.visible = true
				calendar_layer.layer = 2


func _on_calendar_mouse_entered() -> void:
	can_click_calendar = true


func _on_calendar_mouse_exited() -> void:
	can_click_calendar = false
