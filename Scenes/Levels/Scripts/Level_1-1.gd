extends Node2D

func _ready():

	if GlobalLevels.SavePosition1 == false:
		get_node("/root/Level/Player/cam").limit_top = -280
		get_node("/root/Level/Player/cam").limit_bottom = 448
		get_node("/root/Level/Player").ReturnPosition = get_node("/root/Level/TileMaps/PointSaves/position1").global_position
		get_node("/root/Level/Player").position = get_node("/root/Level/TileMaps/PointSaves/position1").global_position
	else:
		get_node("/root/Level/Player").ReturnPosition = get_node("/root/Level/TileMaps/PointSaves/position3").global_position
		get_node("/root/Level/Player").position = get_node("/root/Level/TileMaps/PointSaves/position3").global_position
		get_node("/root/Level/Player/cam").limit_top = 500
		get_node("/root/Level/Player/cam").limit_bottom = 1080

func _on_Door1_body_entered(body):
	if body.TYPE == "PLAYER":
		GlobalLevels.SavePosition1 = true
		transition.fade_to("res://Scenes/Levels/Level_1/Level_1-2.tscn")

func _on_NewLimit_body_entered(body):
	if body.TYPE == "PLAYER":
		get_node("/root/Level/Player/cam").limit_top = 500
		get_node("/root/Level/Player/cam").limit_bottom = 1080

