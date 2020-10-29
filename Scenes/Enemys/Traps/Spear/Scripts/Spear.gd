extends KinematicBody2D
const TYPE = "ENEMY"
export(Vector2) var velocity
export (float) var Speed = 400
const UP = Vector2(0, -1)
export(int) var Direction = -1
export(bool) var move = true
export(float) var TimerSpear = 0

func _physics_process(delta):
	if move:
		TimerSpear += delta
		move_and_slide(velocity, UP)
		velocity.x = Speed * Direction
		if TimerSpear > 10:
			move = false
			$anim.play("Beat")
			yield($anim, "animation_finished")
			queue_free()


func _on_area_body_entered(body):
	if body.TYPE == "PLAYER":
		move = false
		$anim.play("Beat")
		if GlobalPlayer.Left:
			body.velocity.x = -(8 * -576)
		elif GlobalPlayer.Right:
			body.velocity.x = 8 * -576
		body._hurtPlayer(1)
		GlobalPlayer.Score -= 10
		yield($anim, "animation_finished")
		queue_free()


