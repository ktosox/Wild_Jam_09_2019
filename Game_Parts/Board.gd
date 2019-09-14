extends TileMap

const tileOffset = Vector2(22,13)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if(event is InputEventMouseMotion):
		track_mouse()
	if(event.is_action_pressed("LMB")):
		set_cellv(world_to_map(get_global_mouse_position()),0)

func track_mouse():
	var cellPosition = world_to_map(get_global_mouse_position())
	var newPosition = Vector2(0,0)
	newPosition.x = (cellPosition.x-cellPosition.y)*22
	newPosition.y = (cellPosition.x+cellPosition.y+1)*13
	$selector.global_position = newPosition
#	newPosition += (get_global_mouse_position()/tileOffset)
#	newPosition = newPosition.round()
#	if(int(newPosition.x)%2==0 && int(newPosition.y)%2==1):
#		newPosition *= tileOffset
#		$selector.global_position = newPosition
#	if(int(newPosition.x)%2==1 && int(newPosition.y)%2==0):
#		newPosition *= tileOffset
#		$selector.global_position = newPosition

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	
	pass
