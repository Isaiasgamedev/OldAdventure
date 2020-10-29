extends Node

#HUD NEEDS

var Hp
var Sm
var Wp
var Mp
var Score
var Time
var Deaths

#INVENTORY

var WeaponType
var PotionsHP
var PotionsMana

#PLAYER

var PlayerDirection = 0
var Left
var Right
var MovementsActiveted = 1

func _ready():
	Hp = 10
	Sm = 10
	Wp = 0
	Mp = 0
	Time = 0
	Score = 0
	Right = true
	

func _process(delta):
	_DirectionNow()
	
func _DirectionNow():
	if PlayerDirection > 0:
		Right = true
		Left = false
	elif PlayerDirection < 0:
		Left = true
		Right = false
		
func _PointsPlayer(Points):
	Score += Points
	
func _WeaponQuanty(Points):
	Wp += Points
	
func _SpecialMovesQuant(Points):
	Sm += Points
