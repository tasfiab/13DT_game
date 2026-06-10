extends Node
@export var meter_container : VBoxContainer

@export var val_meter : TextureProgressBar
@export var chr_meter : TextureProgressBar
@export var far_meter : TextureProgressBar

@export var happy_meter : TextureProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	val_meter.value = Global.val_meter
	chr_meter.value = Global.chr_meter
	far_meter.value = Global.far_meter
	happy_meter.value = Global.happiness
	
	if Global.learn:
		meter_container.visible = false
	else:
		meter_container.visible = true
