extends Minigame_Part

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.is_dragging = false
	
	label.mouse_entered.connect(_on_mouse_entered)
	label.mouse_exited.connect(_on_mouse_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	dragging()
