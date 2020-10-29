extends Node2D

const TYPE = "PLATAFORM"
var Plataform 
export (PackedScene) var Playeradd

func _ready():
	Plataform = get_parent()


func reparent(child: Node, new_parent: Node):
	var old_parent = child.get_parent()
	old_parent.remove_child(child)
	new_parent.add_child(child)
	print_debug("MUDEI O PAI")

func _on_Area2D_body_entered(body):
	if body.TYPE == "PLAYER":
		body.IsPlataform = true


func _on_Area2D_body_exited(body):
	if body.TYPE == "PLAYER":
		body.IsPlataform = false


