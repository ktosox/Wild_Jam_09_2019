extends KinematicBody2D

var fireData = [
	1, # damange : 1 to 3
	2, #range in cells - 2 to 5
	1, #type : 1 - barrage / 2 - blast / 3 - lasor 
	7, # reused for ammo
	Color(randf(),randf(),randf()) # color data
]
#----------------------------------------------



var blockInput = false
var followPath = false

var moving = true
var painting = false
var shooting = true

var paintedCell = Vector2()

var fireReady = true

var speedMax = 10
var speedCurrent = 0
var speedAcceleration = 5

var playerHP = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	GM.currentPlayer = self
#	update_current_cell()
#	fixLocation()
#	GM.currentBoard.updateInterface(fireData)
	pass # Replace with function body.

#func update_current_cell():
#	currentCell = GM.currentBoard.world_to_map(global_position)
#	z_index=GM.currentBoard.world_to_map(global_position).x+GM.currentBoard.world_to_map(global_position).y

func _input(event):

	if(event.is_action_pressed("ui_select")):
		if(painting):
			start_path()
			pass
		if(shooting):
			if(fireReady ): # and fireData[3]>0  - I cut this out so ammo is infinite
				fireReady = false
				$TimerFireCooldown.start()
				$Canon.fire_bullet()
	#			$Canon.fire_canon(fireData)
	#			fireData[3] -= 1
	#			GM.currentBoard.updateInterface(fireData)
	if(event.is_action_pressed("LMB")):
		if(painting):
			pass
		pass
		
#		if(GM.currentBoard.is_cell_valid(clickedCell)): # this is part of the previous movement system
#			var direction = currentCell - clickedCell
#			if(validDirections.has(direction)):
#				jump_in_direction(direction)
	if(event.is_action_pressed("RMB")):
		if(painting):
			cancel_path()
			shooting = true
		if(shooting):
			paint_path()
		#find the selected cell
		# check if cell is okay
		#jump_in_direction(Vector2((((randi()%2)*2)-1),(((randi()%2)*2)-1)))

#func fixLocation():
#	global_position = GM.currentBoard.global_to_grid(global_position)
	
func _physics_process(delta):

	if(moving):
		move_and_collide(get_local_mouse_position().normalized()*2)
		pass
	
	if(painting): #path painting happens here
		var selection = GM.currentBoard.world_to_map(get_global_mouse_position())
		if ( selection != paintedCell):

			var direction = paintedCell - selection
			if (direction.length()>1):
				print("oops! diagonal!")
				if( abs(selection.x-paintedCell.x)>abs(selection.y-paintedCell.y) ):
					direction.x = 0
				else:
					direction.y = 0
				selection = paintedCell - direction
			var target = Vector2()
			
			target.x = (direction.x-direction.y)*(-22)
			target.y = (direction.x+direction.y)*(-13)
			if(!GM.currentBoard.is_cell_valid(selection) ):
				cancel_path()
			else:
				if(target!=Vector2(0,0)): 
					$PathPreview.add_point($PathPreview.points[$PathPreview.points.size()-1] + target)
				$EndPreview.position += target
				paintedCell = selection
				if $PathPreview.points.size()>4 :
					start_path()
	

func paint_path():
	painting = true
	$PathPreview.visible = true
	print("painting path!")

func cancel_path():
	# called when something goes wrong while painting path
	painting = false
	blockInput = false
	$PathPreview.visible = false
	print("cancelled path!")
	pass

func start_path():
	# called once path is finished
	painting = false
	$PathPreview.visible = false
	$EndPreview.visible = false
	followPath = true
	blockInput = true
	print("path started!")
	pass

func finish_path():
	blockInput = false
	followPath = false
	pass


#func grabToken(newFireData):
#	print("got this from token: ", newFireData)
#	var pattern = [0,1,2]
#	pattern.remove(randi()%3)
#	fireData[pattern[0]] = newFireData[pattern[0]]
#	fireData[pattern[1]] = newFireData[pattern[1]]
#	fireData[3] = newFireData[3]
#	fireData[4] = mergColors(fireData[4],newFireData[4])
#	GM.currentBoard.updateInterface(fireData)
#	pass


#func mergColors(Color1=Color(), Color2=Color()):
#	var newColor = Color()
#	match (randi()%3):
#		0:
#			newColor.r=Color1.r
#			newColor.b=Color2.b
#			newColor.g=(Color1.g + Color2.g)/2.0
#		1:
#			newColor.r=Color2.r
#			newColor.g=Color1.g
#			newColor.b=(Color1.b + Color2.b)/2.0
#
#		2:
#			newColor.g=Color2.g
#			newColor.b=Color1.b
#			newColor.r=(Color1.r + Color2.r)/2.0
#
#
#	return newColor

func _on_TimerFireCooldown_timeout():
	fireReady = true
	pass # Replace with function body.
	

#called when player gets damaged
func damange():
	playerHP -= 1
	#camera shake shood be implemented here
	if(playerHP < 1):
		GM.lose_game()

func pop():
	damange()
	pass

func winGame():
	# - make player immortal
	# - pay a tune?
	blockInput = true
	pass

