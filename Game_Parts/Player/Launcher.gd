extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var active = false

var max_length = 140.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_line():
	return $Line2D.get_point_position(1)-$Line2D.get_point_position(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active :
		Engine.time_scale = 0.1
		$Line2D.visible = true
		var distance = get_local_mouse_position().clamped(max_length)
		$Line2D.set_point_position(0,distance)
		$Line2D.default_color.r = lerp(0,1,distance.length()/max_length)
		$Line2D.default_color.g = inverse_lerp(1,0.5,distance.length()/max_length)
	else:
		Engine.time_scale = 1
		$Line2D.visible = false
	pass
