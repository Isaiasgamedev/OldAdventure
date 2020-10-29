extends KinematicBody2D
#TYPE OF NODE
const TYPE = "PLAYER"

#MOVEMENT NEEDS

const FLOOR_NORMAL = Vector2.UP
const SNAP_DIRECTION = Vector2.DOWN
const SNAP_LENGTH = 32
const SLOPE_LIMIT = deg2rad(45)

export(float) var speed = 250.0
export(float) var gravity = 1500.0
export(float) var jump_strength = 800.0
var snap_vector = SNAP_DIRECTION * SNAP_LENGTH

var direction = Vector2.ZERO
var velocity = Vector2.ZERO

#JUMP NEEDS
export(int) var jumpCount = 0

#STATUS PLAYER

export(bool) var IsHurt = false
export(bool) var IsDeath = false
export(bool) var IsFall = false
export(bool) var Isjumping = false
export(bool) var IsAttack = false
export (int) var ControlAttack = 0
export(bool) var IsPlataform = false

#DEATH AND RETURN

export(Vector2) var ReturnPosition

#ATTACKS NEEDS
export (float) var TimeSpecialAttack = 0.0
export (bool) var SpecialMoveOn = false
var SeconderyCount = 0

func _physics_process(delta):
	#print_debug("CONTROL =  " + str(IsPlataform))
	_move(delta)
	_anim_control()
	_Attack_1()
	_Attack_2(delta)
	_hudControl()
	_cancelMove()
	_SeconderyWeapon()


func _cancelMove():
	if IsHurt || IsDeath || ControlAttack == 2:
		direction.x = 0
		velocity.x = 0
		speed = 0
	else:
		jump_strength = 800.0
		speed = 250.0


func _unhandled_input(event):
	_handle_input(event)


func _handle_input(event):
	if !IsHurt && !IsDeath && ControlAttack <= 1:

		if event.is_action("left") or event.is_action("right"):
			SpecialMoveOn = false
			TimeSpecialAttack = 0
			_update_direction()
		if event.is_action_pressed("ui_space"):
			SpecialMoveOn = false
			TimeSpecialAttack = 0
			_jump()
			Isjumping = true
		elif event.is_action_released("ui_space"):
			SpecialMoveOn = false
			TimeSpecialAttack = 0
			_cancel_jump()
			Isjumping = false

	


func _move(delta):
	velocity.y += gravity * delta
	velocity.y = move_and_slide_with_snap(velocity, snap_vector, FLOOR_NORMAL).y

	if is_on_floor():
		snap_vector = SNAP_DIRECTION * SNAP_LENGTH


func _jump():
	if is_on_floor():
		snap_vector = Vector2.ZERO
		velocity.y = -jump_strength



func _cancel_jump():
	print(velocity.y)
	if not is_on_floor() and velocity.y < 0.0:
		velocity.y = -250.0
		Isjumping = false


func _update_direction():
	if !IsHurt && !IsDeath && ControlAttack <= 1:
		direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
		GlobalPlayer.PlayerDirection = direction.x 
		velocity.x = direction.x * speed
		if not velocity.x == 0:
			pass
			$sprite.flip_h = velocity.x < 0

		var Left = Input.is_action_pressed("left")
		var Right = Input.is_action_pressed("right")

		if Left:
			$Effects.flip_h = false
			$Effects.position = Vector2(-22, -1.6)
			$Attacks/shape.position = Vector2(-20, -3.5)
			$Attacks2/shape.position = Vector2(-18, -3)
			$Second.position = Vector2(12, 5)
			$sprite.flip_h = true
			
		elif Right:
			$Effects.position = Vector2(22, -1.6)
			$Effects.flip_h = true
			$Attacks/shape.position = Vector2(20, -3.5)
			$Attacks2/shape.position = Vector2(18, -3)
			$Second.position = Vector2(-12, 5)
			$sprite.flip_h = false


func _Attack_1():
	if !IsHurt && !IsDeath && !IsAttack:
		if Input.is_action_just_pressed("ui_sword"):
			ControlAttack = 1
			IsAttack = true
			yield($anim, "animation_finished")
			IsAttack = false
			ControlAttack = 0
			SpecialMoveOn = false
			TimeSpecialAttack = 0
			
func _Attack_2(delta):
	if GlobalPlayer.MovementsActiveted > 0:
		if !IsHurt && !IsDeath && !IsAttack && GlobalPlayer.Sm >= 3:
			if Input.is_action_pressed("ui_up"):
				TimeSpecialAttack += delta
				if TimeSpecialAttack > 1:
					$anim2.play("Liberation")
					SpecialMoveOn = true
					TimeSpecialAttack = 0
			if Input.is_action_just_pressed("ui_down"):
				if SpecialMoveOn:
					GlobalPlayer.Sm -= 3
					ControlAttack = 2
					IsAttack = true
					yield($anim, "animation_finished")
					IsAttack = false
					ControlAttack = 0
					SpecialMoveOn = false
					TimeSpecialAttack = 0

func _SeconderyWeapon():
	if SeconderyCount > 0 && GlobalPlayer.Wp > 4:
		if Input.is_action_just_pressed("ui_control"):
			var a = load("res://Scenes/Player/Scenes/"+ (str(SeconderyCount))+".tscn")
			var b = a.instance()
			get_parent().add_child(b)
			b.position = $Second.global_position

func _anim_control():

	if GlobalPlayer.Hp <= 0:
		IsDeath = true
		$anim.play("Death")
		yield($anim, "animation_finished")
		#$anim.stop()
		get_node("/root/Level/Player").position = ReturnPosition
		GlobalPlayer.Hp = 10
		IsDeath = false
		IsHurt = false
		

	if IsAttack && !IsHurt && !IsDeath:
		if ControlAttack == 1:
			$anim.play("Attack_1")
		elif ControlAttack == 2:
			$anim.play("Attack_2")
		

	if IsHurt && !IsDeath:
		$anim.play("Hurt")
		yield($anim, "animation_finished")
		#$anim.stop()
		IsHurt = false

	if !IsAttack && velocity.y > 0 && !IsFall && !IsHurt && !IsDeath:
		if !IsPlataform: 
			IsFall = true
			$anim.play("Fall")
			yield($anim, "animation_finished")
			#$anim.stop()

	if !IsAttack && velocity.y == 0 && !IsHurt && !IsDeath:
		IsFall = false
		if direction.x == 0:
			$anim.play("Idle")
		elif direction.x != 0:
			$anim.play("Walking")

	if !Isjumping && !IsAttack && !IsFall && !IsHurt && !IsDeath:
		if direction.x == 0:
			$anim.play("Idle")
		elif direction.x != 0:
			$anim.play("Walking")

	elif!IsAttack && velocity.y < 0 && !IsHurt && !IsDeath:
		$anim.play("Jump")

func _hurtPlayer(damage):
	if !IsDeath:
		IsHurt = true
		GlobalPlayer.Hp -= damage
		SpecialMoveOn = false
		TimeSpecialAttack = 0

func _on_Attacks_body_entered(body):
	if body.TYPE == "ENEMY":
		body._hurtEnemy(1)
	if body.TYPE == "PROPS":
		body.DestroyProps()
	SpecialMoveOn = false
	TimeSpecialAttack = 0

func _on_Attacks2_body_entered(body):
	if body.TYPE == "ENEMY":
		body._hurtEnemy(5)
	if body.TYPE == "PROPS":
		body.DestroyProps()
	SpecialMoveOn = false
	TimeSpecialAttack = 0


func _hudControl():
	$Hud/CanvasHud/Hp.text = str(GlobalPlayer.Hp)
	$Hud/CanvasHud/Mp.text = str(GlobalPlayer.Sm)
	$Hud/CanvasHud/Wp.text = str(GlobalPlayer.Wp)
	$Hud/CanvasHud/Mg.text = str(GlobalPlayer.Mp)
	$Hud/CanvasHud/Time.text = str(GlobalPlayer.Time)
	$Hud/CanvasHud/Score.text = str(GlobalPlayer.Score)

func _PointsDeath():
	GlobalPlayer._PointsPlayer(-500)
	SpecialMoveOn = false
	TimeSpecialAttack = 0
	






