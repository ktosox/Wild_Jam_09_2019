extends TileMap

const tileOffset = Vector2(22,13)

var invalidCells = [-1,9,15] # cells with magma / water
var claimedCells = [] # cells with something sitting on them
var listedSpawns = [] #every spawn 

# player stats

var playerHP = 3
var playerMOVE = 5


#called when player gets damaged
func damange():
	playerHP -=1
	$Camera2D/Interface/VBoxContainer/HBoxContainer/HP.setValue(String(playerHP))
	#camera shake shood be implemented here
	if(playerHP < 1):
		GM.lose_game()

# Called when the node enters the scene tree for the first time.
func _ready():
	GM.currentBoard = self
	GM.currentCamera = $Camera2D
	$Camera2D/Interface/VBoxContainer/HBoxContainer/HP.setValue(String(playerHP))
	$Camera2D/Interface/VBoxContainer/HBoxContainer/Move.setValue(String(playerMOVE))
	

# Checks if the mouse moved
func _input(event):
	if(event is InputEventMouseMotion):
		track_mouse()
#	if(event.is_action_pressed("LMB")):
#		set_cellv(world_to_map(get_global_mouse_position()),-1)

# Updates selection based on mouse position
func track_mouse():
	var cellPosition = world_to_map(get_global_mouse_position())
	#instead of a singular point two values will need to be extracted
	# one for player position and one for current selection (approximated to a line)
	$selector.global_position = global_to_grid(get_global_mouse_position())
	# color should be adjusted based on current available distance
	if(is_cell_valid(cellPosition)):
		$selector.modulate = Color(0,1,0)
	else:
		$selector.modulate = Color(1,0,0)

# true if a cell is not occupied and is not of a blocked type
func is_cell_valid(cell = Vector2()):
	if(claimedCells.has(cell)):
		return false
	if(invalidCells.has(get_cellv(cell))):
		return false
	else:
		return true

# called when an object blocks a given cell
func claimCell(place =Vector2()):
	claimedCells.push_back(world_to_map(place))
	#print("claimed cells after claim",claimedCells)

# called when an object no longer blocks a given cell
func freeCell(place =Vector2()):
	claimedCells.erase(world_to_map(place))
	#print("claimed cells after free",claimedCells)


func addSpawn(spawn):
	listedSpawns.push_back(spawn)
	pass

func getSpawn():
	return listedSpawns[randi()%listedSpawns.size()]
	pass

#translates a given position from board cell cords to global cords
func cell_to_grid(cell = Vector2()):
	var newPosition = Vector2()
	newPosition.x = (cell.x-cell.y)*22
	newPosition.y = (cell.x+cell.y+1)*13
	return newPosition

# adjusts a global cords to fit in to the grid
func global_to_grid(position = Vector2()):
	var cellPosition = world_to_map(position)
	var newPosition = Vector2()
	newPosition.x = (cellPosition.x-cellPosition.y)*22
	newPosition.y = (cellPosition.x+cellPosition.y+1)*13
	return newPosition
	
# updates interface data
func updateInterface(fireData = []):
	pass
	#on hold due to changes
	#$Camera2D/Interface/power.setValue(String(fireData[0]))
	#$Camera2D/Interface/type.setValue(String(fireData[2]))
	#$Camera2D/Interface/rnge.setValue(String(fireData[1]))
	#$Camera2D/Interface/ammo.setValue(String(fireData[3]))


func endLevel():
	$Camera2D/Interface.visible = false
	$AnimationPlayer.play("trans_out")
	pass

func changeLevel():
	GM.switchLevel()
	pass

func _on_TimerMoveGain_timeout():
	if (playerMOVE < 10):
		playerMOVE += 1
		$Camera2D/Interface/VBoxContainer/HBoxContainer/Move.setValue(String(playerMOVE))
