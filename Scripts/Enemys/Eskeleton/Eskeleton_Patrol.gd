extends KinematicBody2D
const TYPE = "ENEMY"

export(int) var gravity
export(Vector2) var velocity
export(Vector2) var push
export (float) var Speed
const UP = Vector2(0, -1)
export(int) var Direction = 1

var Raise = false
var UnRaise = false
var DanoUnRaise = false
var Time = 0

var Hp = 3
var Ishurt = false

func _physics_process(delta):
	_grativyApply(delta)
	if Hp > 0:
		if $ray2.is_colliding() == true:
			Direction = Direction * -1
			$ray.position.x *= -1
			$ray2.position.x = 6
			$ray2.rotation_degrees *= -1
			
		if $ray.is_colliding() == false:
			
			Direction = Direction * -1
			$ray.position.x *= -1
			$ray2.position.x = 3
			$ray2.rotation_degrees *= -1
	
	
	if DanoUnRaise:
		Time += delta
		if Time > 6:
			DanoUnRaise = false
			Time = 0
			Raise = true
			$anim.play("Raise")
			yield($anim, "animation_finished")
			Raise = false
			$anim.play("walking")
	
	if Hp <= 0:
		_DeathEnemy()
	
	if !Raise && !UnRaise && !DanoUnRaise:
		velocity.x = Speed * Direction
		move_and_slide(velocity)
		if Direction == 1:
			$sprite.flip_h = true
		else:
			$sprite.flip_h = false
	
func _grativyApply(delta):
	velocity.y += gravity * delta
	move_and_slide(UP)


func _DeathEnemy():
	if Hp <= 0:
		Ishurt = true
		$anim.play("Death")
		yield($anim, "animation_finished")
		queue_free()
		
func _PointsSkeleton():
	GlobalPlayer._PointsPlayer(200)

func _hurtEnemy(damage):
	if !Raise && !UnRaise && !DanoUnRaise:
		if Ishurt == false:
			Ishurt = true
			Hp -= damage
			$anim.play("Hurt")
			yield($anim, "animation_finished")
			$anim.stop()
			Ishurt = false
			$anim.play("walking")



func _on_damage_body_entered(body):
	if body.TYPE == "PLAYER":
		if body.IsHurt == false:
			DanoUnRaise = true
#			if GlobalPlayer.Left:
#				body.velocity.x = -(8 * -576)
#			elif GlobalPlayer.Right:
#				body.velocity.x = 8 * -576

			body._hurtPlayer(1)
			GlobalPlayer.Score -= 10
			$anim.play("UnRaise")
			yield($anim, "animation_finished")
			


func _on_VisibilityNotifier2D_screen_entered():
	Raise = true
	$anim.play("Raise")
	yield($anim, "animation_finished")
	$anim.stop()
	Raise = false
	$anim.play("walking")

func _on_VisibilityNotifier2D_screen_exited():
	UnRaise = true
	$anim.play("UnRaise")
	yield($anim, "animation_finished")
	$anim.stop()
	UnRaise = false
