extends KinematicBody2D
const TYPE = "BOX"

export(int) var gravity
export(Vector2) var velocity
export (float) var Speed
const UP = Vector2(0, -1)
export(int) var Direction = 1
var push = false




func _physics_process(delta):
	velocity.y += gravity * delta
	move_and_slide(velocity, UP)
	if push:
		if GlobalPlayer.PlayerDirection == 1:
			velocity.x = Speed * Direction
		elif GlobalPlayer.PlayerDirection == -1:
			velocity.x = Speed * -Direction



func _on_area_body_entered(body):
	if body.TYPE == "PLAYER":
		push = true
		velocity = Vector2()
		Direction = 1
		Speed = 20


func _on_area_body_exited(body):
	if body.TYPE == "PLAYER":
		push = false
		velocity = Vector2.ZERO
		Direction = 0
		Speed = 0
