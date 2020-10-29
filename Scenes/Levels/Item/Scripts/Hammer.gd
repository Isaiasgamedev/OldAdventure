extends KinematicBody2D

const TYPE = "NEWMOVEMENT"

export (Vector2) var velocity = Vector2.ZERO
var gravity = 800

func _physics_process(delta):
	_ApplyGravity(delta)
	
func _ApplyGravity(delta):
	velocity.y += gravity * delta
	move_and_slide(velocity)


func _on_area_body_entered(body):
	if body.TYPE == "PLAYER":
		$anim.play("vanish")
		yield($anim, "animation_finished")
		GlobalPlayer.MovementsActiveted = 1
		queue_free()
