extends Area2D

func _ready():
	fixLocation()


func fixLocation():
	global_position = GM.currentBoard.global_to_grid(global_position)
	
func _on_Exit_area_entered(area):
	$AnimationPlayer.play("active")
	area.winGame()
	GM.currentBoard.endLevel()
	pass # Replace with function body.
