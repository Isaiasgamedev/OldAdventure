extends Area2D

func _on_Axe_body_entered(body):
	if body.TYPE == "PLAYER":
		body.SeconderyCount = 1
		$anim.play("get")
