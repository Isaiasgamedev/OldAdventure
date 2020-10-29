extends Node2D

var Door1

func _ready():

	get_node("/root/Level/Player/cam").limit_right = 5925
	get_node("/root/Level/Player/cam").limit_top = -810
	get_node("/root/Level/Player/cam").limit_bottom = 1950
	get_node("/root/Level/Player").ReturnPosition = get_node("/root/Level/TileMaps/PointSaves/position1").global_position
	get_node("/root/Level/Player").global_position = get_node("/root/Level/TileMaps/PointSaves/position1").global_position





func _on_Door1_body_entered(body):
	if body.TYPE == "PLAYER":
		get_tree().change_scene("res://Scenes/Levels/Level_1/Level_1-3.tscn")
		
func _on_Door2_body_entered(body):
	if body.TYPE == "PLAYER":
		get_tree().change_scene("res://Scenes/Levels/Level_1/Level_1-5.tscn")
		
func _on_area_body_entered(body):
	if body.TYPE == "PLAYER":
		$Switchs/anim.play("Switch1Active")
		yield($Switchs/anim, "animation_finished")
		$Doors/Door4/anim.play("Open")
	if body.TYPE == "BOX":
		$Switchs/anim.play("Switch1Active")
		yield($Switchs/anim, "animation_finished")
		$Doors/Door4/anim.play("Open")

func _on_area_body_exited(body):
	if body.TYPE == "PLAYER":
		$Switchs/anim.play_backwards("Switch1Active")
		yield($Switchs/anim, "animation_finished")
		$Doors/Door4/anim.play_backwards("Open")
	if body.TYPE == "BOX":
		$Switchs/anim.play_backwards("Switch1Active")
		yield($Switchs/anim, "animation_finished")
		$Doors/Door4/anim.play_backwards("Open")


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
#


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







func _on_Player_body_entered(body):
	if body.TYPE == "PLAYER":
		$PlataformFinal/anim.play("Final")


func _on_Player_body_exited(body):
	if body.TYPE == "PLAYER":
		$PlataformFinal/anim.play_backwards("Final")
