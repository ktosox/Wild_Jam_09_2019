extends Node2D


var previewRange = 100

var previewLimit = 400

var previewLenght = 0

var painting = true

var target = Vector2(0,0)



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if (painting):
		if(event.is_action_pressed("LMB")):
			add_point()
		if(event.is_action_pressed("RMB")):
			clear_path()

func _process(delta):
	if(painting):
		update_path()

func get_points():
	var stuff = Array($Line.points)
	stuff.pop_back()
	stuff.pop_front()
	for n in stuff.size():
		stuff[n]+=global_position
	if stuff.size()<1 and !$Ray.is_colliding() :
		stuff.append(get_local_mouse_position().clamped(previewRange)+global_position)
	return stuff


func update_path():
	target = get_local_mouse_position().clamped(previewRange)
	$Ray.cast_to = target
	if ($Ray.is_colliding()):
		$Line.modulate = Color(1,0,0)
	else:
		$Line.modulate = Color(0,1,0)
	$Line.set_point_position(0,target)

func add_point():
	if $Ray.is_colliding() :
		return
	if (previewLenght > previewLimit):
		return
	var currentPosition = global_position
	global_position = get_global_mouse_position()
	previewLenght += global_position.distance_to(currentPosition)
	for j in $Line.get_point_count() :
		$Line.set_point_position(j, $Line.get_point_position(j)+currentPosition-global_position)
	$Line.add_point(Vector2(),0)

func clear_path():
	for i in $Line.points.size() :
		$Line.remove_point(0)
	$Line.add_point(Vector2())
	$Line.add_point(Vector2())
	previewLenght = 0
	position = Vector2(0,-10)
