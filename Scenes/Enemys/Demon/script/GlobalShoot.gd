extends Area2D

export (int) var speed = 2
var velocity = Vector2()
var ChangeAnim = false



func _process(delta):
	if !ChangeAnim:
		$anim.play("Intro")
		yield($anim, "animation_finished")
		ChangeAnim = true
	else:
		$anim.play("power")
		
	
	
	if GlobalLevels.SideBoss == 0:
		velocity.x = -speed
	else:
		velocity.x = speed
	translate(velocity)


func _on_visible_screen_exited():
	queue_free()


func _on_Power_body_entered(body):
	if body.TYPE == "PLAYER":
		if body.IsHurt == false:
			if GlobalPlayer.Left:
				body.velocity.x = -(8 * -576)
			elif GlobalPlayer.Right:
				body.velocity.x = 8 * -576

			body._hurtPlayer(2)
			GlobalPlayer.Score -= 100
