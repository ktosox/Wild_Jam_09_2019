extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	fixLocation()
	pass # Replace with function body.




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func fixLocation():
	global_position = GM.currentBoard.global_to_grid(global_position)
	
func _on_Exit_area_entered(area):
	$AnimationPlayer.play("active")
	area.winGame()
	pass # Replace with function body.
