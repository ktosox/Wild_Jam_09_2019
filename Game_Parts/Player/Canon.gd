extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var fireRange = 1 # 1 to 5 / range in cells
var fireType = 0 # 0 - nothing / 1 - barrage / 2 - blast / 3 - lasor 
var fireColor = Color()
var fireParticle = 1 # 1 to 3


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
