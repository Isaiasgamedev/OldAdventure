extends Node2D

var back = true

func _ready():


	if GlobalLevels.SavePosition2 == false:
		get_node("/root/Level/Player/cam").limit_right = 1335
		get_node("/root/Level/Player/cam").limit_top = 504
		get_node("/root/Level/Player/cam").limit_bottom = 780
		get_node("/root/Level/Player").ReturnPosition = get_node("/root/Level/TileMaps/PointSaves/position1").global_position
		get_node("/root/Level/Player").position = get_node("/root/Level/TileMaps/PointSaves/position1").global_position
	else:
		get_node("/root/Level/Player/cam").limit_right = 1335
		get_node("/root/Level/Player/cam").limit_top = -300
		get_node("/root/Level/Player/cam").limit_bottom = 504
		get_node("/root/Level/Player").ReturnPosition = get_node("/root/Level/TileMaps/PointSaves/position3").global_position
		get_node("/root/Level/Player").position = get_node("/root/Level/TileMaps/PointSaves/position3").global_position




func _on_NewLimit_body_entered(body):
	if body.TYPE == "PLAYER":
		if back == true:
			back = false
			get_node("/root/Level/Player").ReturnPosition = get_node("/root/Level/TileMaps/PointSaves/position2").global_position
			get_node("/root/Level/Player/cam").limit_right = 1335
			get_node("/root/Level/Player/cam").limit_top = -300
			get_node("/root/Level/Player/cam").limit_bottom = 504

func _on_NewLimit_body_exited(body):
	if body.TYPE == "PLAYER":
		if back == false:
			back = true
			get_node("/root/Level/Player").ReturnPosition = get_node("/root/Level/TileMaps/PointSaves/position1").global_position
			get_node("/root/Level/Player/cam").limit_right = 1335
			get_node("/root/Level/Player/cam").limit_top = 504
			get_node("/root/Level/Player/cam").limit_bottom = 780


func _on_Door1_body_entered(body):
	if body.TYPE == "PLAYER":
		GlobalLevels.SavePosition2 = true
		transition.fade_to("res://Scenes/Levels/Level_1/Level_1-3.tscn")


func _on_Door2_body_entered(body):
	if body.TYPE == "PLAYER":
		transition.fade_to("res://Scenes/Levels/Level_1/Level_1-1.tscn")
