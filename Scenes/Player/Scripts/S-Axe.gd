extends Area2D


func _ready():
	if GlobalPlayer.Wp > 4:
		GlobalPlayer.Wp -= 5
		if GlobalPlayer.Right:
			$anim.play("AxeRight")
	
		if GlobalPlayer.Left:
			$anim.play("AxeLeft")
	else:
		queue_free()

func _on_Axe_body_entered(body):
	if body.TYPE == "ENEMY":
		if GlobalPlayer.Right:
			$anim.play("ColisionRight")
			body._hurtEnemy(3)
		if GlobalPlayer.Left:
			$anim.play("ColisionLeft")
			body._hurtEnemy(3)


	if body.TYPE == "PROPS":
		if GlobalPlayer.Right:
			$anim.play("ColisionRight")
			body.DestroyProps()
		if GlobalPlayer.Left:
			$anim.play("ColisionLeft")
			body.DestroyProps()

