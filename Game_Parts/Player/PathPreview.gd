extends Node2D


var previewRange = 300

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
	return stuff


func update_path():
	target = get_local_mouse_position().clamped(previewRange)
	$Ray.cast_to = target
	$Line.set_point_position(0,target)

func add_point():
	var currentPosition = global_position
	global_position = get_global_mouse_position()
	for j in $Line.get_point_count() :
		$Line.set_point_position(j, $Line.get_point_position(j)+currentPosition-global_position)
	$Line.add_point(Vector2(),0)

func clear_path():
	for i in $Line.points.size() :
		$Line.remove_point(0)
	$Line.add_point(Vector2())
	$Line.add_point(Vector2())
