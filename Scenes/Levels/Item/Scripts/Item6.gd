extends KinematicBody2D

const TYPE = "ITEM"

export (Vector2) var velocity = Vector2.ZERO
var gravity = 200
var off = false
var time = 0.0

func _physics_process(delta):
	if !off:
		_ApplyGravity(delta)
	
func _ApplyGravity(delta):
	time += delta
	if time > 10.0:
		$anim.play("FinishCoin")
		yield($anim, "animation_finished")
		queue_free()
	velocity.y += gravity * delta
	move_and_slide(velocity)


func _on_area_body_entered(body):
	if body.TYPE == "PLAYER":
		off = true
		$anim.play("TakeCoin")
		yield($anim, "animation_finished")


func _PointsWeapon():
	GlobalPlayer._SpecialMovesQuant(5)
