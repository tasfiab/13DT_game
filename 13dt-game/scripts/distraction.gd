extends Minigame_Part


func _ready() -> void:
	speed = Global.dis_speed
	Global.is_dragging = false
	
	self.mouse_entered.connect(_on_mouse_entered)
	self.mouse_exited.connect(_on_mouse_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	dragging()
	
