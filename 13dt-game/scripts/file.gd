const PATH := 'user://'
var file_name : String = "save.tres"
var access : FileAccess
var data : Data

var key : String
var encryption : Encryption

func _ready() -> void:
	encryption = ResourceLoader.load("res://resources/encryption.tres")

# Makes new game
func new_game() -> void:
	data = Data.new()


# Saves game
func save_game() -> void:
	ResourceSaver.save(data, PATH + file_name)


# Loads game
func load_game() -> void:
	if ResourceLoader.exists(PATH + file_name):
		data = ResourceLoader.load(PATH + file_name)
		
