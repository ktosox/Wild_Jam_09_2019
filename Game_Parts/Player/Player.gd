extends KinematicBody2D

var fireData = [
	1, # damange : 1 to 3
	2, #range in cells - 2 to 5
	1, #type : 1 - barrage / 2 - blast / 3 - lasor 
	7, # reused for ammo
	Color(randf(),randf(),randf()) # color data
]
#----------------------------------------------


var selected = false

var moving = false
var shooting = false

var fireReady = true

var moveForce = Vector2(0,0)

func _ready():
	GM.currentPlayer = self

func _input(event):

	if(event.is_action_pressed("ui_select")):
		if(fireReady):
			shoot()


	if(event.is_action_pressed("LMB")):
		if(selected):
			$Launcher.active = true
	if(event.is_action_released("LMB")):
		if($Launcher.active):
			$Launcher.active = false
			moveForce = $Launcher.get_line()
#			var output = $Launcher.get_line()
#			print("power: ",output.length()," - angle: ",output.normalized())
		pass
#	if(event.is_action_pressed("RMB")):
#		if(painting):
#			cancel_path()
#		elif(!moving):
#			paint_path()

	
func _physics_process(delta):
	var colision = move_and_collide(moveForce*6*delta)
	moveForce = moveForce.clamped(moveForce.length()-moveForce.length()*delta)
	if(colision!=null):
		bounce(colision.normal)
	pass
	

func bounce(normal):
	moveForce = moveForce.bounce(normal)
	pass

func shoot():
	$Canon.fire_bullet()
	fireReady = false
	$TimerFireCooldown.start()
	pass


func _on_TimerFireCooldown_timeout():
	fireReady = true
	if(Input.is_action_pressed("ui_select") ):
		shoot()
	pass # Replace with function body.
	

#called when player gets damaged
func damange():
	GM.playerHP -= 1
	#camera shake shood be implemented here
	if(GM.playerHP < 1):
		GM.lose_game()

func pop():
	damange()
	pass

func winGame():
	# - make player immortal
	# - pay a tune?
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


func _on_Player_mouse_entered():
	selected = true
	pass # Replace with function body.


func _on_Player_mouse_exited():
	selected = false
	pass # Replace with function body.
