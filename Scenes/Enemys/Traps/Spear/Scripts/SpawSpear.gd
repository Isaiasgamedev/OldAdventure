extends Node2D

export (PackedScene) var Spear
export (float) var TimerTrap
export (bool) var Activated = false

func _physics_process(delta):
	if Activated:
		TimerTrap += delta
		if TimerTrap > 3:
			_ActivateTrap()
			TimerTrap = 0


func _ActivateTrap():
	var b = Spear.instance()
	b.position = $position.global_position
	get_parent().add_child(b)


func _on_Activated_body_entered(body):
	if body.TYPE == "PLAYER":
		Activated = true


func _on_VisibilityNotifier2D_screen_exited():
	Activated = false
