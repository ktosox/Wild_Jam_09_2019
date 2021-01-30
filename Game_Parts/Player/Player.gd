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

var moving = false
var painting = true
var shooting = false

var paintedCell = Vector2()

var fireReady = true

var speedMax = 100
var speedCurrent = 0
var speedAcceleration = 90

var target = Vector2()
var lastTarget = false
var targetList = []

var playerHP = 10


func _ready():
	GM.currentPlayer = self

func _input(event):

	if(event.is_action_pressed("ui_select")):
		if(painting):
			start_path()
		else:
			paint_path()
			pass
		if(shooting):
			$Canon.fire_bullet()
#			if(fireReady ): # and fireData[3]>0  - I cut this out so ammo is infinite
#				fireReady = false
#				$TimerFireCooldown.start()
#				
#	#			$Canon.fire_canon(fireData)
#	#			fireData[3] -= 1
#	#			GM.currentBoard.updateInterface(fireData)
#	if(event.is_action_pressed("LMB")):
#		if(painting):
#			start_path()
#			pass
#		pass
		
#		if(GM.currentBoard.is_cell_valid(clickedCell)): # this is part of the previous movement system
#			var direction = currentCell - clickedCell
#			if(validDirections.has(direction)):
#				jump_in_direction(direction)
	if(event.is_action_pressed("RMB")):
		if(painting):
			shooting = true
			painting = false
#			shooting = true
		if(shooting):
			shooting = false
			painting = true
#			paint_path()
		#find the selected cell
		# check if cell is okay
		#jump_in_direction(Vector2((((randi()%2)*2)-1),(((randi()%2)*2)-1)))

	
func _physics_process(delta):

	if(moving):
		var endPos =  target - global_position

		
		move_and_collide(endPos.normalized()*speedCurrent*delta)
		if(target.distance_to(global_position)<2):
			target_reached()
		if(lastTarget and target.distance_to(global_position)<60):
			speedCurrent -= speedAcceleration*delta 
			speedCurrent = max(30,speedCurrent)
		elif(speedCurrent<speedMax):
			speedCurrent+=speedAcceleration*delta
			
		pass
	
	if(painting): #path painting happens here
		pass

func target_reached():
	print("reached")
	lastTarget = false
	if(targetList.size()==1):
		lastTarget = true
		print("last target!")
	if (targetList.size()<1):
		finish_path()
	else:
		target = targetList.pop_back()
		print(target)
	pass

func paint_path():
	painting = true
	$PathPreview.clear_path()
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
	moving = true
	blockInput = true
	print($PathPreview.get_points())
	targetList = $PathPreview.get_points()
	for n in targetList.size() :
		targetList[n]-=Vector2(0,-10)
	target_reached()

	print("path started!")
	pass

func finish_path():
	blockInput = false
	moving = false
	painting = true
	speedCurrent=0
	$PathPreview.clear_path()
	$PathPreview.visible = true
	pass



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


#OLD PAITING
#		var selection = GM.currentBoard.world_to_map(get_global_mouse_position())
#		if ( selection != paintedCell):
#
#			var direction = paintedCell - selection
#			if (direction.length()>1):
#				print("oops! diagonal!")
#				if( abs(selection.x-paintedCell.x)>abs(selection.y-paintedCell.y) ):
#					direction.x = 0
#				else:
#					direction.y = 0
#				selection = paintedCell - direction
#			var target = Vector2()
#
#			target.x = (direction.x-direction.y)*(-22)
#			target.y = (direction.x+direction.y)*(-13)
#			if(!GM.currentBoard.is_cell_valid(selection) ):
#				cancel_path()
#			else:
#				if(target!=Vector2(0,0)): 
#					$PathPreview.add_point($PathPreview.points[$PathPreview.points.size()-1] + target)
#				$EndPreview.position += target
#				paintedCell = selection
#				if $PathPreview.points.size()>4 :
#					start_path()

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

#func fixLocation():
#	global_position = GM.currentBoard.global_to_grid(global_position)

#func update_current_cell():
#	currentCell = GM.currentBoard.world_to_map(global_position)
#	z_index=GM.currentBoard.world_to_map(global_position).x+GM.currentBoard.world_to_map(global_position).y
