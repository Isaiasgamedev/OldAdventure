extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		transition.fade_to("res://Scenes/Levels/Level_1/Level_1-1.tscn")
