extends Node

@export var important : Label
@export var distraction : Label
@export var target_node : Node

const DIS_SCENE := preload("res://scenes/distraction.tscn")
const IMP_SCENE := preload("res://scenes/important_info.tscn")

var dis_speed := 50
var imp_speed := 1
var time := 0.0
var radius := 1

var draggable := false
var offset : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta * imp_speed
	
	if important != null:
		important.global_position = Vector2(important.global_position.x + sin(time) * radius, important.global_position.y + cos(time) * radius)
	
	if distraction != null:
		distraction.global_position = distraction.global_position.move_toward(target_node.global_position, dis_speed * delta)


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
