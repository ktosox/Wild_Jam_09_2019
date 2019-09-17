extends Node2D

var fireData = [
	1, # damange : 1 to 3
	2, #range in cells - 2 to 5
	3, #type : 1 - barrage / 2 - blast / 3 - lasor 
	4, # particle type - 1 to 3
	Color() # color data
]
#----------------------------------------------

var validDirections = [
	Vector2(0,-1),
	Vector2(0,1),
	Vector2(-1,0),
	Vector2(1,0)
]

var currentDirection = Vector2(1,0)
var currentCell = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	update_current_cell()
	fixLocation()
	pass # Replace with function body.

func update_current_cell():
	currentCell = GM.currentBoard.world_to_map(global_position)

func _input(event):
	if(event.is_action_pressed("ui_select")):
		$Canon.fire_canon(fireData)
	if(event.is_action_pressed("LMB")):
		var clickedCell = GM.currentBoard.world_to_map(get_global_mouse_position())
		if(GM.currentBoard.is_cell_valid(clickedCell)):
			var direction = currentCell - clickedCell
			if(validDirections.has(direction)):
				jump_in_direction(direction)
		#find the selected cell
		# check if cell is okay
		#jump_in_direction(Vector2((((randi()%2)*2)-1),(((randi()%2)*2)-1)))

func fixLocation():
	global_position = GM.currentBoard.global_to_grid(global_position)



func jump_to_cell(targetCell = Vector2()):
	
	pass
	
func jump_in_direction(direction = Vector2()):

	var target = Vector2()
	target.x = (direction.x-direction.y)*(-22)
	target.y = (direction.x+direction.y)*(-13)
	$Path2D.updatePath(target)
	var directionAnimation
	match(direction):
		Vector2(0,-1):
			directionAnimation = "SW"
		Vector2(0,1):
			directionAnimation = "NE"
		Vector2(1,0):
			directionAnimation = "NW"
		Vector2(-1,0):
			directionAnimation = "SE"
	$Path2D/PathFollow2D/Node2D/AnimationPlayer.play(directionAnimation)
	currentDirection = direction
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

