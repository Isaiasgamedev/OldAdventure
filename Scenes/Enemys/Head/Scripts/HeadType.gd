extends KinematicBody2D

const TYPE = "ENEMY"

const UP = Vector2(0, -1)
export(Vector2) var push
var Hp = 2

func _ready():
	$anim.play("move")


func _process(delta):
	if Hp <= 0:
		$anim.play("Death")
		yield($anim, "animation_finished")
		get_owner().queue_free()


func _PointsSkeleton():
	GlobalPlayer._PointsPlayer(200)

func _hurtEnemy(damage):	
	Hp -= damage
	$anim.play("Hurt")
	yield($anim, "animation_finished")
	$anim.play("move")



func _on_area_body_entered(body):
	if body.TYPE == "PLAYER":
		if body.IsHurt == false:
			if GlobalPlayer.Left:
				body.velocity.x = -(8 * -576)
			elif GlobalPlayer.Right:
				body.velocity.x = 8 * -576

			body._hurtPlayer(1)
			GlobalPlayer.Score -= 10
