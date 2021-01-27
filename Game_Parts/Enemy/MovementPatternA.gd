extends Path2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_direction(target):
	var direction
	if(GM.currentBoard == null):
		direction = global_position - target.global_position
	else:
		direction =  target.global_position - global_position + Vector2(randf()-0.5,randf()-0.5 )*10
	return direction.normalized()
	pass
