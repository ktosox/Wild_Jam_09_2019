extends TileMap

const tileOffset = Vector2(22,13)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var invalidCells = [-1,9,15]
var claimedCells = []
var listedSpawns = []



func damange():
	$Camera2D/Interface/NinePatchRect/HP.value -=1
	if($Camera2D/Interface/NinePatchRect/HP.value == 0):
		GM.lose_game()

# Called when the node enters the scene tree for the first time.
func _ready():
	GM.currentBoard = self
	GM.currentCamera = $Camera2D
	pass # Replace with function body.

func _input(event):
	if(event is InputEventMouseMotion):
		track_mouse()
#	if(event.is_action_pressed("LMB")):
#		set_cellv(world_to_map(get_global_mouse_position()),-1)

func track_mouse():
	var cellPosition = world_to_map(get_global_mouse_position())
	$selector.global_position = global_to_grid(get_global_mouse_position())
	if(is_cell_valid(cellPosition)):
		$selector.modulate = Color(0,1,0)
	else:
		$selector.modulate = Color(1,0,0)

func is_cell_valid(cell = Vector2()):
	if(claimedCells.has(cell)):
		return false
	if(invalidCells.has(get_cellv(cell))):
		return false
	else:
		return true

func claimCell(place =Vector2()):
	claimedCells.push_back(world_to_map(place))
	#print("claimed cells after claim",claimedCells)
	pass

func addSpawn(spawn):
	listedSpawns.push_back(spawn)
	pass

func getSpawn():
	return listedSpawns[randi()%listedSpawns.size()]
	pass

func freeCell(place =Vector2()):
	claimedCells.erase(world_to_map(place))
	#print("claimed cells after free",claimedCells)
	pass

func cell_to_grid(cell = Vector2()):
	var newPosition = Vector2()
	newPosition.x = (cell.x-cell.y)*22
	newPosition.y = (cell.x+cell.y+1)*13
	return newPosition
	pass

func global_to_grid(position = Vector2()):
	var cellPosition = world_to_map(position)
	var newPosition = Vector2()
	newPosition.x = (cellPosition.x-cellPosition.y)*22
	newPosition.y = (cellPosition.x+cellPosition.y+1)*13
	return newPosition
# Called every frame. 'delta' is the elapsed time since the previous frame.
func updateInterface(fireData = []):
	$Camera2D/Interface/power.setValue(String(fireData[0]))
	$Camera2D/Interface/type.setValue(String(fireData[2]))
	$Camera2D/Interface/rnge.setValue(String(fireData[1]))
	$Camera2D/Interface/ammo.setValue(String(fireData[3]))
	pass
func endLevel():
	$Camera2D/Interface.visible = false
	$AnimationPlayer.play("trans_out")
	pass

func changeLevel():
	GM.switchLevel()
	pass