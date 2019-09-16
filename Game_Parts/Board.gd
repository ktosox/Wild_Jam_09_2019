extends TileMap

const tileOffset = Vector2(22,13)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var invalidCells = [-1,9,15]

# Called when the node enters the scene tree for the first time.
func _ready():
	GM.currentBoard = self
	pass # Replace with function body.

func _input(event):
	if(event is InputEventMouseMotion):
		track_mouse()
	if(event.is_action_pressed("LMB")):
		set_cellv(world_to_map(get_global_mouse_position()),-1)

func track_mouse():
	var cellPosition = world_to_map(get_global_mouse_position())
	$selector.global_position = global_to_grid(get_global_mouse_position())
	if(is_cell_valid(cellPosition)):
		$selector.modulate = Color(1,1,1)
	else:
		$selector.modulate = Color(0,0,1)

func is_cell_valid(cell = Vector2()):
	if(invalidCells.has(get_cellv(cell))):
		return false
	else:
		return true

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
func _physics_process(delta):
	
	
	pass
