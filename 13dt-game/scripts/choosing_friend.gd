extends Node
@export var friends_container : HBoxContainer
@export var options_container : HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	friends_container.visible = true
	options_container.visible = false
	Global.val_chosen = false
	Global.chr_chosen = false
	Global.far_chosen = false
	Global.learn = false
	Global.talk = false
	#await Global.friend_chosen


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_val_button_pressed() -> void:
	button_pressed()
	Global.val_chosen = true
	Global.val_meter += 5
	
	Global.far_meter -= 2
	Global.chr_meter -= 2

func _on_chr_button_pressed() -> void:
	button_pressed()
	Global.chr_chosen = true
	Global.chr_meter += 5
	
	Global.far_meter -= 2
	Global.val_meter -= 2


func _on_far_button_pressed() -> void:
	button_pressed()
	Global.far_chosen = true
	Global.far_meter += 5
	
	Global.chr_meter -= 2
	Global.val_meter -= 2

func button_pressed():
	Global.friend_chosen.emit()
	friends_container.visible = false
	options_container.visible = true


func _on_learn_pressed() -> void:
	Global.learn = true
	option_pressed()



func _on_talk_pressed() -> void:
	Global.talk = true
	option_pressed()


func option_pressed():
	Global.option_chosen.emit()
	options_container.visible = false 
