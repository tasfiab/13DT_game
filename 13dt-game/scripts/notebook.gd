extends Node
@export var pg_1 : TextureRect
@export var pg_2 : TextureRect
@export var pg_3 : TextureRect
@export var pg_4 : TextureRect

const LEFT_PAGE := Vector2(42,48)
const RIGHT_PAGE := Vector2(524,48)

var page_num := 0
var previous_page := 0

#var pages = get_tree().get_nodes_in_group("page")
var pg = ["pg_1","pg_2", "pg_3", "pg_4"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for page in get_tree().get_nodes_in_group("page"):
		page.position = RIGHT_PAGE
	
	for page in get_tree().get_nodes_in_group("page_text"):
		page.visible = false
	for page in get_tree().get_nodes_in_group("page"):
		Global.lessons += 1
		await get_tree().create_timer(1).timeout
		page.visible = true
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.lessons < 4:
		for num in range(Global.lessons):
			get_tree().get_nodes_in_group("page_text")[num].visible = true
		


func _page_turned_forward() -> void:
	if page_num <= 3:
		if page_num != 4:
			page_num += 1
		previous_page = page_num - 1
		print(page_num)
		print(previous_page)
		
		var tween : Tween = create_tween()
		if page_num < 3:
			get_tree().get_nodes_in_group("page")[page_num].move_child(self, -1)
		tween.tween_property(get_tree().get_nodes_in_group("page")[previous_page], 
								"position", LEFT_PAGE, 0.1)
		#get_tree().get_nodes_in_group("page")[page_num].z_index = page_num

func _page_turned_back() -> void:
	if page_num >= 0:
		page_num -= 1
		if page_num < 3:
			previous_page = page_num + 1
		var tween : Tween = create_tween()
		tween.tween_property(get_tree().get_nodes_in_group("page")[previous_page], 
								"position", RIGHT_PAGE, 0.1)
		#get_tree().get_nodes_in_group("page")[page_num].z_index = page_num
		if page_num != 0:
			get_tree().get_nodes_in_group("page")[page_num].move_child(self, -1)
		print(page_num)
		print(previous_page)


func go_forward():
	page_num = (page_num + 1) % get_tree().get_nodes_in_group("page").size()


func go_backward():
	page_num = ((page_num - 1 + get_tree().get_nodes_in_group("page").size()) 
				% get_tree().get_nodes_in_group("page").size())
