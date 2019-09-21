extends Node2D

var blastScene = load("res://Game_Parts/Player/Blast.tscn")

func fire_canon(fireArray):
	match(fireArray[2]):
		1:
			fireBarrage(fireArray)
		2:
			fireBlast(fireArray)
		3:
			fireLazor(fireArray)

func fireBlast(fireData):
	var blast = blastScene.instance()
	blast.global_position=global_position
	var direction = get_parent().currentDirection
	blast.linear_velocity.y = (direction.x+direction.y) * (-52)
	blast.linear_velocity.x = (direction.x-direction.y) * (-88)
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