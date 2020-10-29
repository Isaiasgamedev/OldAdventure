extends Node2D

var Door1

func _ready():


	if GlobalLevels.SavePosition4 == false:
		get_node("/root/Level/Player/cam").limit_right = 6390
		get_node("/root/Level/Player/cam").limit_top = -500
		get_node("/root/Level/Player/cam").limit_bottom = 730
		get_node("/root/Level/Player").ReturnPosition = get_node("/root/Level/TileMaps/PointSaves/position1").global_position
		get_node("/root/Level/Player").position = get_node("/root/Level/TileMaps/PointSaves/position1").global_position
	else:
		get_node("/root/Level/Player").ReturnPosition = get_node("/root/Level/TileMaps/PointSaves/position2").global_position
		get_node("/root/Level/Player").position = get_node("/root/Level/TileMaps/PointSaves/position2").global_position



func _on_NewLimit_body_entered(body):
	if body.TYPE == "PLAYER":
		get_node("/root/Level/Player").ReturnPosition = get_node("/root/Level/TileMaps/PointSaves/position2").global_position
		get_node("/root/Level/Player/cam").limit_right = 3135
		get_node("/root/Level/Player/cam").limit_top = -500
		get_node("/root/Level/Player/cam").limit_bottom = 385

func _on_NewLimit_body_exited(body):
	if body.TYPE == "PLAYER":
		get_node("/root/Level/Player").ReturnPosition = get_node("/root/Level/TileMaps/PointSaves/position1").global_position
		get_node("/root/Level/Player/cam").limit_right = 3135
		get_node("/root/Level/Player/cam").limit_top = 375
		get_node("/root/Level/Player/cam").limit_bottom = 1150

func _on_Door1_body_entered(body):
	if body.TYPE == "PLAYER":
		transition.fade_to("res://Scenes/Levels/Level_1/Level_1-3.tscn")
		
func _on_Door2_body_entered(body):
	if body.TYPE == "PLAYER":
		transition.fade_to("res://Scenes/Levels/Level_1/Level_1-5.tscn")
		
func _on_area_body_entered(body):
	if body.TYPE == "PLAYER":
		$Switchs/anim.play("Switch1Active")
		yield($Switchs/anim, "animation_finished")
		$Doors/Door/anim.play("Open")
	if body.TYPE == "BOX":
		$Switchs/anim.play("Switch1Active")
		yield($Switchs/anim, "animation_finished")
		$Doors/Door/anim.play("Open")

func _on_area_body_exited(body):
	if body.TYPE == "PLAYER":
		$Switchs/anim.play_backwards("Switch1Active")
		yield($Switchs/anim, "animation_finished")
		$Doors/Door/anim.play_backwards("Open")
	if body.TYPE == "BOX":
		$Switchs/anim.play_backwards("Switch1Active")
		yield($Switchs/anim, "animation_finished")
		$Doors/Door/anim.play_backwards("Open")

func _on_area2_body_entered(body):
	if body.TYPE == "PLAYER":
		$Switchs/anim.play("Switch2Active")
		yield($Switchs/anim, "animation_finished")
		$Doors/Door2/anim.play("Open")
	if body.TYPE == "BOX":
		$Switchs/anim.play("Switch2Active")
		yield($Switchs/anim, "animation_finished")
		$Doors/Door2/anim.play("Open")

func _on_area2_body_exited(body):
	if body.TYPE == "PLAYER":
		$Switchs/anim.play_backwards("Switch2Active")
		yield($Switchs/anim, "animation_finished")
		$Doors/Door2/anim.play_backwards("Open")
	if body.TYPE == "BOX":
		$Switchs/anim.play_backwards("Switch2Active")
		yield($Switchs/anim, "animation_finished")
		$Doors/Door2/anim.play_backwards("Open")

func _on_HideArea_body_entered(body):
	if body.TYPE == "PLAYER":
		$HideArea/anim.play("hide")

func _on_HideArea_body_exited(body):
	if body.TYPE == "PLAYER":
		$HideArea/anim.play_backwards("hide")

func _on_area3_body_entered(body):
	if body.TYPE == "PLAYER":
		$Switchs/anim.play("Switch3Active")
		yield($Switchs/anim, "animation_finished")
		$Doors/Door3/anim.play("Open")
	if body.TYPE == "BOX":
		$Switchs/anim.play("Switch3Active")
		yield($Switchs/anim, "animation_finished")
		$Doors/Door3/anim.play("Open")

func _on_area3_body_exited(body):
	if body.TYPE == "PLAYER":
		$Switchs/anim.play_backwards("Switch3Active")
		yield($Switchs/anim, "animation_finished")
		$Doors/Door3/anim.play_backwards("Open")
	if body.TYPE == "BOX":
		$Switchs/anim.play_backwards("Switch3Active")
		yield($Switchs/anim, "animation_finished")
		$Doors/Door3/anim.play_backwards("Open")
