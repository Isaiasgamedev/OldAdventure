extends KinematicBody2D
const TYPE = "ENEMY"
onready var Player= get_node("/root/Level/Player/")
export (int) var Speed = 250
export (int) var Hp = 3
export (bool) var move = false
export (bool) var Hurt = false
export (float) var TimerDamage = 0.0
export (bool) var Controldamage = false

func _process(delta):
	if Controldamage:
		TimerDamage += delta
		Hurt = true
		if TimerDamage > 1.5:
			Controldamage = false
			Hurt = false
			TimerDamage = 0.0
	
	
	if !Hurt:
		_MoveGhostfront(delta)
	elif Hurt:
		_MoveGhostback(delta)
	
	_DeathEnemy()
	
func _MoveGhostfront(delta):
	if Player != null:
		var PlayerPosition = Player.position
		var Direction = (PlayerPosition - position).normalized()
		var Motion = Direction * Speed * delta
		
		if move:
			position += Motion
			
		
		
func _MoveGhostback(delta):
	if Player != null:
		var PlayerPosition = Player.position
		var Direction = (PlayerPosition - position).normalized()
		var Motion = Direction * Speed * delta
		
		if move:
			position -= Motion
			
		

func _DeathEnemy():
	if Hp <= 0:
		Hurt = true
		$anim.play("Death")
		yield($anim, "animation_finished")
		queue_free()


func _hurtEnemy(damage):
	if !Hurt:
		Hurt = true
		Hp -= damage
		$anim.play("Hurt")
		yield($anim, "animation_finished")
		Hurt = false
		$anim.play("move")

func _on_area_body_entered(body):
	if body.TYPE == "PLAYER":
		move = true
		$sprite.flip_h = false

func _on_area_body_exited(body):
	if body.TYPE == "PLAYER":
		move = false

func _on_area2_body_entered(body):
	if body.TYPE == "PLAYER":
		move = true
		$sprite.flip_h = true

func _on_area2_body_exited(body):
	if body.TYPE == "PLAYER":
		move = false



func _on_Damage_body_entered(body):
	if body.TYPE == "PLAYER":
		if body.IsHurt == false:
			Controldamage = true
			if GlobalPlayer.Left:
				body.velocity.x = -(8 * -576)
			elif GlobalPlayer.Right:
				body.velocity.x = 8 * -576
			body._hurtPlayer(1)
			GlobalPlayer.Score -= 10









