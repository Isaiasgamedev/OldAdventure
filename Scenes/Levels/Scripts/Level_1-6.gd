extends Node2D
enum {
	FisrtState,
	SecondState,
	ThirdState
}

var state = FisrtState

export (bool) var BossOn1 = false
export (bool) var BossOn2 = false
export (bool) var BossOn3 = false
export (float) var timerattack = 0.0
export (float) var timerwait = 0.0
export (int) var bosscount = 0

func _ready():
	get_node("/root/Level/Player/cam").limit_top = -2250
	get_node("/root/Level/Player/cam").limit_bottom = 670
	get_node("/root/Level/Player/cam").limit_right = 775

func _process(delta):
	_BossStateMachine()
	_ControlbBossMachine(delta)

func _GetPosition():
	$Demon.position.x = $Player.position.x
	yield($anim, "animation_finished")
	$Demon/anim.play("attack1")
	yield($Demon/anim, "animation_finished")
	$Demon/anim.play("idle")

func _on_area1_body_entered(body):
	if body.TYPE == "PLAYER":
		get_node("/root/Level/Player/cam").limit_right = 1590

func _ControlbBossMachine(delta):
	
	if BossOn1:
		timerattack += delta
		if timerattack > 20:
			bosscount += 1
			BossOn1 = false
			timerattack = 0
	if bosscount > 2:
		state = SecondState
		timerattack += delta
		if timerattack > 10:
			state = ThirdState
			bosscount = 0
			BossOn1 = false
			BossOn2 = false
			BossOn3 = false
			timerattack = 0



func _BossStateMachine():
	match state:
		FisrtState:
			if !BossOn1:
				BossOn1 = true
				$anim.play("FistState")
				yield($anim, "animation_finished")


		SecondState:
			if !BossOn2:
				BossOn2 = true
				$Demon/anim.play("summon")
				yield($anim, "animation_finished")

	return null
