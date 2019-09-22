extends Node2D

var fireData = [
	1, # damange : 1 to 3
	2, #range in cells - 2 to 5
	1, #type : 1 - barrage / 2 - blast / 3 - lasor 
	7, # reused for ammo
	Color(randf(),randf(),randf()) # color data
]
#----------------------------------------------

var validDirections = [
	Vector2(0,-1),
	Vector2(0,1),
	Vector2(-1,0),
	Vector2(1,0)
]

var currentDirection = Vector2(0,1)
var currentCell = Vector2()

var blockInput = false
var fireReady = true
# Called when the node enters the scene tree for the first time.
func _ready():
	update_current_cell()
	fixLocation()
	GM.currentBoard.updateInterface(fireData)
	pass # Replace with function body.

func update_current_cell():
	currentCell = GM.currentBoard.world_to_map(global_position)
	z_index=GM.currentBoard.world_to_map(global_position).x+GM.currentBoard.world_to_map(global_position).y

func _input(event):
	if(blockInput):
		return
	if(event.is_action_pressed("ui_select")):
		if(fireReady and fireData[3]>0):
			fireReady = false
			$TimerFireCooldown.start()
			$Canon.fire_canon(fireData)
			fireData[3] -= 1
			GM.currentBoard.updateInterface(fireData)
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


func jump_in_direction(direction = Vector2()):
	blockInput = true
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
func grabToken(newFireData):
	print("got this from token: ", newFireData)
	var pattern = [0,1,2]
	pattern.remove(randi()%3)
	fireData[pattern[0]] = newFireData[pattern[0]]
	fireData[pattern[1]] = newFireData[pattern[1]]
	fireData[3] = newFireData[3]
	fireData[4] = mergColors(fireData[4],newFireData[4])
	GM.currentBoard.updateInterface(fireData)
	pass

func jumpComplete():
	blockInput = false
	var targetPosition = $Path2D/PathFollow2D.global_position
	$Path2D/PathFollow2D.unit_offset = 0
	$Path2D/PathFollow2D2.unit_offset = 0
	global_position=targetPosition
	update_current_cell()
	pass

func mergColors(Color1=Color(), Color2=Color()):
	var newColor = Color()
	match (randi()%3):
		0:
			newColor.r=Color1.r
			newColor.r=Color2.b
			newColor.g=(Color1.g + Color2.g)/2.0
		1:
			newColor.r=Color2.r
			newColor.g=Color1.g
			newColor.b=(Color1.b + Color2.b)/2.0
			
		2:
			newColor.g=Color1.g
			newColor.b=Color2.b
			newColor.r=(Color1.r + Color2.r)/2.0
			

	return newColor

func _on_TimerFireCooldown_timeout():
	fireReady = true
	pass # Replace with function body.
	

func pop():
	GM.currentBoard.damange()
	pass

func winGame():
	# - make player immortal
	# - pay a tune?
	blockInput = true
	pass

