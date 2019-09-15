extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var currentCell = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	update_current_cell()
	fixLocation()
	pass # Replace with function body.

func update_current_cell():
	currentCell = GM.currentBoard.world_to_map(global_position)

func _input(event):
	if(event.is_action_pressed("LMB")):
		jump_in_direction(Vector2((((randi()%2)*2)-1),(((randi()%2)*2)-1)))

func fixLocation():
	global_position = GM.currentBoard.global_to_grid(global_position)



func jump_to_cell(targetCell = Vector2()):
	
	pass
	
func jump_in_direction(direction = Vector2()):
	direction *= Vector2(22,13)
	$Path2D.updatePath(direction)
	#$Path2D.curve = updatePath(GM.currentBoard.cell_to_grid(currentCell+direction))
#	$Path2D.curve.add_point(global_position)
#	$Path2D.curve.add_point(GM.currentBoard.cell_to_grid(currentCell+direction))
	$AnimationPlayer.play("move")
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func jumpComplete():
	var targetPosition = $Path2D/PathFollow2D.global_position
	$Path2D/PathFollow2D.unit_offset = 0
	$Path2D/PathFollow2D2.unit_offset = 0
	global_position=targetPosition
	update_current_cell()
	pass

