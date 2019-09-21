extends Node2D

var blastScene = load("res://Game_Parts/Player/Blast.tscn")

func fire_canon(fireData):
	$AnimationPlayer.stop()
	$AnimationPlayer.play(String(fireData[3]))
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
	get_parent().get_parent().add_child(blast)
	pass
	
func fireBarrage(fireData):
	print("barrage")
	pass
	
func fireLazor(fireData):
	print("lazor")
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass 