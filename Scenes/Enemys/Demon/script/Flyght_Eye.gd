extends KinematicBody2D
const TYPE = "ENEMY"


export(Vector2) var velocity
export(Vector2) var push
export (float) var Speed = 200
const UP = Vector2(0, -1)
export(int) var Direction = -1
var change = false
var Raise = true
var Attack = false
var Time = 0

var Hp = 3
var Ishurt = false


func _ready():
	$anim.play("Fly")

func _physics_process(delta):

	if change == true:
		Time += delta
		if Time >= 0.5:
			change = false
			Time = 0

	if Raise && !Ishurt:
		move_and_slide(velocity, UP)
		velocity.x = Speed * Direction
	if is_on_wall() && !change:
		change = true
		Direction *= -1
	if Direction == 1 && Raise:
		$sprite.flip_h = false
	elif Direction == -1 && Raise:
		$sprite.flip_h = true

	if Hp <= 0:
		Ishurt = true
		$anim.play("Death")
		yield($anim, "animation_finished")
		queue_free()

func _PointsFlyght():
	GlobalPlayer._PointsPlayer(200)

func _hurtEnemy(damage):
	if Raise:
		if Ishurt == false:
			Ishurt = true
			Hp -= damage
			$anim.play("Hurt")
			yield($anim, "animation_finished")
			$anim.stop()
			Ishurt = false
			$anim.play("Fly")



func _on_damage_body_entered(body):
	if body.TYPE == "PLAYER":
		if body.IsHurt == false:
			Raise = false
			$anim.play("Attack1")
			if GlobalPlayer.Left:
				body.velocity.x = -(8 * -576)
			elif GlobalPlayer.Right:
				body.velocity.x = 8 * -576
				
			body._hurtPlayer(2)
			GlobalPlayer.Score -= 20
			yield($anim, "animation_finished")
			$anim.stop()
			Raise = true
			Direction = Direction * -1
			$anim.play("Fly")


