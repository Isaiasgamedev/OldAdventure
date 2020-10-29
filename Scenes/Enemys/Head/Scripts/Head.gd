extends Path2D

const UP = Vector2(0, -1)
export(Vector2) var push
var Hp = 2

export (float) var speed = 200.0

func _process(delta):
	$follow.set_offset($follow.get_offset() + speed * delta)


