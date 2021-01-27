extends Node2D


var HP = 3

func _ready():
	fixLocation()
	GM.currentBoard.claimCell(global_position)
#	z_index=GM.currentBoard.world_to_map(global_position).x+GM.currentBoard.world_to_map(global_position).y
	
func fixLocation():
	global_position = GM.currentBoard.global_to_grid(global_position)

func getGibbed():
	GM.currentBoard.freeCell(global_position)
	$AnimationPlayer.play("death")

func getHit():
	$AnimationPlayer.play("Damange")

# once bullet gets rewritten one of these will have to go
func _on_Crate_body_entered(body):
	HP-=1
	if(HP<1):
		getGibbed()
	else:
		getHit()
	body.pop()

func _on_Crate_area_entered(area):
	HP-=1
	if(HP<1):
		getGibbed()
	else:
		getHit()
	area.pop()

