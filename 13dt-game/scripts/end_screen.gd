extends Node
@export var val_label : Label
@export var chr_label : Label
@export var far_label : Label

@export var happiness : Label

const VAL_TEXT := "Val: "
const CHR_TEXT := "Christine: "
const FAR_TEXT := "Farah: "

const HAP_TEXT := "Happiness: "

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	val_label.text = VAL_TEXT + str(Global.val_meter)
	chr_label.text = CHR_TEXT + str(Global.chr_meter)
	far_label.text = FAR_TEXT + str(Global.far_meter) 
	
	happiness.text = HAP_TEXT + str(Global.happiness)
