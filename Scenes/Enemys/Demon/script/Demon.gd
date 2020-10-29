extends KinematicBody2D

const TYPE = "ENEMY"

export (Vector2) var velocity = Vector2.ZERO
export (float) var gravity = 1500.0
export (bool) var Ishurt
export (int) var Hp = 100
export (int) var SummonCount = 0
export (float) var TeleportTimer = 0.0
export (bool) var TeleportOn = false
export (int) var TeleportControl = 0
export (float) var TimerAnim = 0.0
export (float) var TimerSummon = 0.0
export (bool) var SummonOn = false
export (PackedScene) var Skeletor
export (PackedScene) var fly
export (PackedScene) var Skull

export (PackedScene) var MagePower



func _process(delta):
	if !TeleportOn:
		_ApplyGravity(delta)
	if TeleportOn:
		_TeleportPosition(delta)
	if SummonOn:
		_ActivateSpawn(delta)

func _ApplyGravity(delta):
	velocity.y += gravity * delta
	move_and_slide(velocity)


func _hurtEnemy(damage):
	if Ishurt == false:
		Ishurt = true
		Hp -= damage
		$anim.play("Hurt")
		yield($anim, "animation_finished")
		Ishurt = false
		$anim.play("idle")

func _TeleportPosition(delta):
	TeleportTimer += delta
	if TeleportControl == 0:
		TimerAnim += delta
		$anim.play("Teleport")
		if TimerAnim > 1.7:
			$".".position = get_node("/root/Level/BossSpawn/positionboss1").global_position
			$sprite.flip_h = false
			GlobalLevels.SideBoss = 0
			$anim.play("idle")
			var a = MagePower.instance()
			a.position = get_node("/root/Level/BossSpawn/positionboss3").global_position
			get_parent().add_child(a)
			TeleportControl = 1
			TimerAnim = 0
			print("estou aqui 1")
	elif TeleportControl == 1:
		if TeleportTimer > 20:
			TimerAnim += delta
			$anim.play("Teleport")
			yield($anim, "animation_finished")
			if TimerAnim > 1.4:
				$".".position = get_node("/root/Level/BossSpawn/positionboss2").global_position
				$sprite.flip_h = true
				GlobalLevels.SideBoss = 1
				$anim.play("idle")
				var a = MagePower.instance()
				a.position = get_node("/root/Level/BossSpawn/positionboss4").global_position
				get_parent().add_child(a)
				TeleportControl = 2
				TimerAnim = 0
				print("estou aqui 2")
	elif TeleportControl == 2:
		if TeleportTimer > 40:
			TimerAnim += delta
			$anim.play("Teleport")
			yield($anim, "animation_finished")
			if TimerAnim > 1.4:
				$".".position = get_node("/root/Level/BossSpawn/positionboss1").global_position
				$anim.play("summon2")
				$sprite.flip_h = false
				GlobalLevels.SideBoss = 0
				$anim.play("idle")
				var a = MagePower.instance()
				a.position = get_node("/root/Level/BossSpawn/positionboss3").global_position
				get_parent().add_child(a)
				TeleportControl = 3
				TimerAnim = 0
				print("estou aqui 3")
	elif TeleportControl == 3:
		if TeleportTimer > 60:
			TimerAnim += delta
			$anim.play("Teleport")
			yield($anim, "animation_finished")
			if TimerAnim > 1.4:
				$".".position = get_node("/root/Level/BossSpawn/positionboss2").global_position
				$sprite.flip_h = true
				GlobalLevels.SideBoss = 1
				$anim.play("idle")
				var a = MagePower.instance()
				a.position = get_node("/root/Level/BossSpawn/positionboss4").global_position
				get_parent().add_child(a)
				TeleportControl = 4
				TimerAnim = 0
				print("estou aqui 4")
	elif TeleportControl == 4:
		if TeleportTimer > 80:
			TeleportTimer = 0
			TeleportOn = false
			TeleportControl = 0
			print("estou aqui 5")
			print(TeleportOn)

func _ActiveSpawnOn():
	SummonOn = true

func _ActivateSpawn(delta):
	print(TimerSummon)
	TimerSummon += delta
	if SummonCount == 0:
		var a = Skeletor.instance()
		a.position = get_node("/root/Level/PositionSpawn/Spawn1").global_position
		get_parent().add_child(a)
		$anim.play("idle")
		SummonCount += 1
		print(SummonCount)
	if (SummonCount == 1):
		if TimerSummon > 10:
			$anim.play("summon2")
			if TimerSummon > 13:
				var b = fly.instance()
				b.position = get_node("/root/Level/PositionSpawn/Spawn2").global_position
				get_parent().add_child(b)
				$anim.play("idle")
				SummonCount += 1
				print(SummonCount)
	if (SummonCount == 2):
		if TimerSummon > 20:
			$anim.play("summon2")
			if TimerSummon > 23:
				var c = Skull.instance()
				c.position = get_node("/root/Level/PositionSpawn/Spawn3").global_position
				get_parent().add_child(c)
				$anim.play("idle")
				SummonCount += 1
				print(SummonCount)
	if (SummonCount == 3):
		if TimerSummon > 30:
			TeleportOn = true
			SummonOn = false
			TimerSummon = 0
			SummonCount = 0
