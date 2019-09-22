extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var HP = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	fixLocation()
	GM.currentBoard.claimCell(global_position)
	z_index=GM.currentBoard.world_to_map(global_position).x+GM.currentBoard.world_to_map(global_position).y
	pass # Replace with function body.
func fixLocation():
	global_position = GM.currentBoard.global_to_grid(global_position)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

	

func getGibbed():
	GM.currentBoard.freeCell(global_position)
	$AnimationPlayer.play("death")

func getHit():
	$AnimationPlayer.play("Damange")
	pass

func _on_Crate_body_entered(body):
	HP-=1
	if(HP<1):
		getGibbed()
	else:
		getHit()
	body.pop()
	pass # Replace with function body.
