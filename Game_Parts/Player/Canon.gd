extends Node2D

var blastScene = load("res://Game_Parts/Player/Blast.tscn")

func fire_canon(fireArray):
	var blast = blastScene.instance()
	blast.global_position=global_position
	var direction = get_parent().currentDirection
	blast.linear_velocity.y = (direction.x+direction.y) * (-26)
	blast.linear_velocity.x = (direction.x-direction.y) * (-44)
	get_parent().get_parent().add_child(blast)
		
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass 