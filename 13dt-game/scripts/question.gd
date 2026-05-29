extends Node

@export var panel = Panel
@export var label := Label

const START = "Violet! What did you get for "

var answered = false

var letter = ['(a)','(b)','(c)','(d)']

var topics = ['Algebra ', 'Trigonometry ', 'Graphs ', 'Geometry ', 'Statistics ',
				'Language Features ', 'Essays ', 'Grammar ', 'Themes ',
				'Chemistry ', 'Physics ', 'Biology ']


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	while not Global.game_end:
		await Global.learn_end
		var chance = randi_range(1,4)
		if chance == 1:
			panel.visible = true
			label.text = START + topics.pick_random() + str(randi_range(1,4)) + letter.pick_random()
		await get_tree().create_timer(20).timeout
		if not answered:
			label.text = "never mind"
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
