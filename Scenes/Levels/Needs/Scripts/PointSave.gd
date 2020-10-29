extends Area2D



func _on_PointSave_body_entered(body):
	if body.TYPE == "PLAYER":
		$anim.play("Get")
		get_node("/root/Level/Player").ReturnPosition = $".".global_position
