extends Node2D

var blastScene = load("res://Game_Parts/Player/Blast.tscn")
var barrageScene = load("res://Game_Parts/Player/Barrage.tscn")

func fire_canon(fireData):
	match(fireData[2]):
		1:
			fireBarrage(fireData)
		2:
			fireBlast(fireData)
		3:
			fireLazor(fireData)

func fireBlast(fireData):
	var blast = blastScene.instance()
	blast.global_position=global_position
	var direction = get_parent().currentDirection
	blast.linear_velocity.y = (direction.x+direction.y) * (-65)
	blast.linear_velocity.x = (direction.x-direction.y) * (-110)
	blast.modulate = fireData[4]
	blast.lifetime = fireData[1]
	get_parent().get_parent().add_child(blast)
	pass
	
func fireBarrage(fireData):
	var barrage = barrageScene.instance()
	barrage.global_position=global_position
	var direction = get_parent().currentDirection
	barrage.linear_velocity.y =( (direction.x+direction.y) * (-26) ) + (-13 + randi()%26 )
	barrage.linear_velocity.x =( (direction.x-direction.y) * (-44) ) + (-22 + randi()%44 )
	barrage.modulate = fireData[4]
	barrage.lifetime = fireData[1]
	get_parent().get_parent().add_child(barrage)
	pass
	
func fireLazor(fireData):
	$Node2D.modulate=fireData[4]
	$Node2D.scale.x = fireData[1] * 0.2
	$Node2D/AnimationPlayer.play("fire")
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass 