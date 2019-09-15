extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var HP = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	fixLocation()
	pass # Replace with function body.
func fixLocation():
	global_position = GM.currentBoard.global_to_grid(global_position)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
