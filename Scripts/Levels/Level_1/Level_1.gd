extends TileMap

const TYPE = "MAP"




func _on_spikes_body_entered(body):
	if body.TYPE == "PLAYER":
		body._hurtPlayer(GlobalPlayer.Hp)
