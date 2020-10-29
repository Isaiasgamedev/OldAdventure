extends StaticBody2D

const TYPE = "PROPS"
var ItemLoad = false

func DestroyProps():
	if !ItemLoad:
		ItemLoad = true
		$anim.play("Broken")
		yield($anim, "animation_finished")
		$anim.stop()
		GlobalPlayer.Score += 10
		GlobalLevels.PositionItem = $".".global_position
		GlobalLevels._LeaveItemObjects()
		
		queue_free()
