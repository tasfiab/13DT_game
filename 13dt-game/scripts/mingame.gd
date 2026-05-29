extends Node

@export var important : Label
@export var distraction : Label
@export var target_node : Node

@export var text_box := Panel
@export var question := Label

@export var cam := Camera2D

const INIT_POS := Vector2(576,324)
const DOWN_POS := Vector2(576,524)
const LEFT_POS := Vector2(-576,324)

const DIS_SCENE := preload("res://scenes/distraction.tscn")
const IMP_SCENE := preload("res://scenes/important_info.tscn")

const START := "Violet! What did you get for "
const Q := "Q"

var dis_speed := 50
var imp_speed := 1
var time := 0.0
var radius := 1

var draggable := false
var offset : Vector2

var minigame_start = false
var question_asked = false

var answered = false

var topics = ['Algebra ', 'Trig ', 'Graphs ', 'Calc ', 'Stats ',
				'Language Features ', 'Essays ', 'Grammar ', 'Themes ',
				'Chemistry ', 'Physics ', 'Biology ']

var ans = {
	"Algebra" : {
		"Q1" : "a",
		"Q2" : "b",
		"Q3" : "a",
		"Q4" : "c"
	},
	"Trig" : {
		"Q1" : "c",
		"Q2" : "d",
		"Q3" : "a",
		"Q4" : "d"
	},
	"Graphs" : {
		"Q1" : "d",
		"Q2" : "a",
		"Q3" : "b",
		"Q4" : "d"
	},
	"Calc" : {
		"Q1" : "b",
		"Q2" : "b",
		"Q3" : "c",
		"Q4" : "d"
	},
	"Stats" : {
		"Q1" : "b",
		"Q2" : "a",
		"Q3" : "b",
		"Q4" : "c"
	},
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cam.position = INIT_POS
	text_box.visible = false
	while not Global.game_end:
		minigame_start = true
		await get_tree().create_timer(10).timeout
		minigame_start = false
		
		var chance = randi_range(1,4)
		
		if chance == 1 and Global.lessons > 0:
			question_asked = true
			text_box.visible = true
			var topic = randi_range(0, (Global.lessons - 1))
			question.text = START + topics[topic] + Q + str(randi_range(1,4)) 
			
			await get_tree().create_timer(10).timeout
			
			if not answered:
				question.text = "never mind"
		
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if minigame_start:
		time += delta * imp_speed
		
		if important != null:
			important.global_position = Vector2(important.global_position.x + sin(time) * radius, 
												important.global_position.y + cos(time) * 
												radius)
		
		if distraction != null:
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
			tween.tween_property(cam, "global_position", DOWN_POS, 0.3)
		
		elif Input.is_action_just_pressed(LEFT):
			var tween : Tween = create_tween()
			tween.tween_property(cam, "global_position", LEFT_POS, 0.3)
		
		elif Input.is_action_just_pressed(RIGHT) or  Input.is_action_just_pressed(UP):
			var tween : Tween = create_tween()
			tween.tween_property(cam, "global_position", INIT_POS, 0.3)

func _on_head_entered(area: Area2D) -> void:
	if area.has_meta('distraction'):
		Global.happiness -= 5
		print(Global.happiness)
		distraction.queue_free()
		await get_tree().create_timer(1).timeout
		var instance = DIS_SCENE.instantiate()
		instance.global_position = Vector2(randi_range(1,500),randi_range(1,500))
		add_child(instance)
		distraction = instance

	elif area.has_meta('important'):
		Global.happiness += 5
		print(Global.happiness)
		important.queue_free()
		important = null
		await get_tree().create_timer(1).timeout
		var imp_instance = IMP_SCENE.instantiate()
		imp_instance.global_position = Vector2(randi_range(1,500),randi_range(1,500))
		add_child(imp_instance)
		important = imp_instance
