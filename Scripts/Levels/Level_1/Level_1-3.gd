extends Node2D

func _ready():


	if GlobalLevels.SavePosition3 == false:
		get_node("/root/Level/Player/cam").limit_right = 3135
		get_node("/root/Level/Player/cam").limit_top = 383
		get_node("/root/Level/Player/cam").limit_bottom = 1150
		get_node("/root/Level/Player").ReturnPosition = get_node("/root/Level/TileMaps/PointSaves/position1").global_position
		get_node("/root/Level/Player").position = get_node("/root/Level/TileMaps/PointSaves/position1").global_position
	else:
		get_node("/root/Level/Player/cam").limit_right = 3135
		get_node("/root/Level/Player/cam").limit_top = 383
		get_node("/root/Level/Player/cam").limit_bottom = 1150
		get_node("/root/Level/Player").ReturnPosition = get_node("/root/Level/TileMaps/PointSaves/position2").global_position
		get_node("/root/Level/Player").position = get_node("/root/Level/TileMaps/PointSaves/position2").global_position

func _on_NewLimit_body_entered(body):
	if body.TYPE == "PLAYER":
		get_node("/root/Level/Player").ReturnPosition = get_node("/root/Level/TileMaps/PointSaves/position2").global_position
		get_node("/root/Level/Player/cam").limit_right = 3135
		get_node("/root/Level/Player/cam").limit_top = -500
		get_node("/root/Level/Player/cam").limit_bottom = 400

func _on_NewLimit_body_exited(body):
	if body.TYPE == "PLAYER":
		get_node("/root/Level/Player").ReturnPosition = get_node("/root/Level/TileMaps/PointSaves/position1").global_position
		get_node("/root/Level/Player/cam").limit_right = 3135
		get_node("/root/Level/Player/cam").limit_top = 375
		get_node("/root/Level/Player/cam").limit_bottom = 1150

func _on_Door1_body_entered(body):
	if body.TYPE == "PLAYER":
		GlobalLevels.SavePosition3 = true
		transition.fade_to("res://Scenes/Levels/Level_1/Level_1-4.tscn")


func _on_NewLimit2_body_entered(body):
	if body.TYPE == "PLAYER":
		get_node("/root/Level/Player").ReturnPosition = get_node("/root/Level/TileMaps/PointSaves/position4").global_position
		get_node("/root/Level/Player/cam").limit_right = 3135
		get_node("/root/Level/Player/cam").limit_top = 375
		get_node("/root/Level/Player/cam").limit_bottom = 1150

