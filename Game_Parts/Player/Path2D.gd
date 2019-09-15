extends Path2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func updatePath(target = Vector2()):

	var newCurve = Curve2D.new()
	newCurve.add_point(Vector2(0,0))
	newCurve.add_point(target)
	curve = newCurve
#	print(curve.get_point_position(0),curve.get_point_position(1))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
