extends Node


#BOOLS FOR MAP

#BOOlS FOR SAVE POSITION
var SavePosition1 = false
var SavePosition2 = false
var SavePosition3 = false
var SavePosition4 = false
var SavePosition5 = false
var SavePosition6 = false
var SavePosition7 = false
var SavePosition8 = false
var SavePosition9 = false
var SavePosition10 = false

var PositionItem = Vector2.ZERO

var iten_random_1 = 1
var iten_random_2 = 2
var iten_random_3 = 3
var iten_random_4 = 4
var iten_random_5 = 5
var iten_random_6 = 6


var SideBoss = 0


func _LeaveItemObjects():
	
	var ItemLeave = load("res://Scenes/Levels/Item/Scenes/Item"+ (str(_rand_iten()))+".tscn")
	var ItemInstace = ItemLeave.instance()
	get_parent().add_child(ItemInstace)
	ItemInstace.position = PositionItem

func _rand_iten():
	var d = randi() % 6 + 1
	match d:
		1:
			return iten_random_1
		2:
			return iten_random_2
		3:
			return iten_random_3
		4:
			return iten_random_4
		5:
			return iten_random_5
		6:
			return iten_random_6


