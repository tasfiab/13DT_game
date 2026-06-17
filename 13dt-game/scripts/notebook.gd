extends Node
@export var pg_1 : TextureRect
@export var pg_2 : TextureRect
@export var pg_3 : TextureRect
@export var pg_4 : TextureRect

const LEFT_PAGE := Vector2(42,48)
const RIGHT_PAGE := Vector2(524,48)

var page_num := 0
var previous_page := 0


var initial_z_index : Dictionary = {
}

var back_z_index : Dictionary = {
	
}

#var pages = get_tree().get_nodes_in_group("page")
var pg : Array = []


#var pgs : Array = get_tree().get_nodes_in_group("page")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pg.assign(get_tree().get_nodes_in_group("page"))
	for page in pg:
		page.position = RIGHT_PAGE
		back_z_index[page] = page.z_index
		initial_z_index[page] = len(pg) - pg.find(page)
		page.z_index = initial_z_index[page]
	print(Global.lessons)
	
	for page in get_tree().get_nodes_in_group("page_text"):
		page.visible = false
		
		
		#Global.pages_done += 1
		#await get_tree().create_timer(1).timeout
		#page.visible = true
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for num in range(0, Global.pages_done):
	#for num in range(0,len(pg)):
		get_tree().get_nodes_in_group("page_text")[num].visible = true
		


func _page_turned_forward() -> void:
	for page in pg:
		if pg.find(page) > (page_num) + 1:
			page.z_index = initial_z_index[page]
	
	if page_num < len(pg):
		page_num += 1
		previous_page = page_num - 1
		var pre_pre_page = page_num - 2
		print(page_num)
		print(previous_page)
		
		var tween : Tween = create_tween()
		if page_num < 12:
			pg[previous_page].z_index += page_num
		tween.tween_property(pg[previous_page], "position", LEFT_PAGE, 0.1)
		await tween.finished
		pg[pre_pre_page].z_index -= page_num
		#get_tree().get_nodes_in_group("page")[page_num].z_index = page_num
	else:
		for page in pg:
			var tween : Tween = create_tween()
			tween.tween_property(page, "position", RIGHT_PAGE, 0.1)
			page.z_index = initial_z_index[page]
			page_num = 0

func _page_turned_back() -> void:
	for page in pg:
		if pg.find(page) < (page_num - 1):
			page.z_index = back_z_index[page]
	if page_num >= 0:
		page_num -= 1
		#if page_num < 3:
		previous_page = page_num + 1
		var pre_pre_page = page_num + 2
		#get_tree().get_nodes_in_group("page")[page_num].z_index = page_num
		if page_num != 0 and page_num < 12:
			pg[previous_page].z_index += page_num
		var tween : Tween = create_tween()
		tween.tween_property(pg[previous_page], "position", RIGHT_PAGE, 0.1)
		#pg[pre_pre_page] = page_num + 2
		print(page_num)
		print(previous_page)


func go_forward():
	page_num = (page_num + 1) % get_tree().get_nodes_in_group("page").size()


func go_backward():
	page_num = ((page_num - 1 + get_tree().get_nodes_in_group("page").size()) 
				% get_tree().get_nodes_in_group("page").size())
