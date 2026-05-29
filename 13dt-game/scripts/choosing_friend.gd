extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_val_button_pressed() -> void:
	Global.val_chosen.emit()


func _on_chr_button_pressed() -> void:
	Global.chr_chosen.emit()


func _on_far_button_pressed() -> void:
	Global.far_chosen.emit()
