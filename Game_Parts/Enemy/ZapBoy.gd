extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var currentCell = Vector2()



# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	fixLocation()
	update_current_cell()
	pass # Replace with function body.


func update_current_cell():
	currentCell = GM.currentBoard.world_to_map(global_position)
	z_index=GM.currentBoard.world_to_map(global_position).x+GM.currentBoard.world_to_map(global_position).y

func fixLocation():
	global_position = GM.currentBoard.global_to_grid(global_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func move():
	
	var options = [
	Vector2(0,-1),
	Vector2(0,1),
	Vector2(-1,0),
	Vector2(1,0)
]
	var selection  = randi()%options.size()
	if(GM.currentBoard.is_cell_valid(currentCell - options[selection])):
		jump_in_direction(options[selection])
		print("moving!")


func jump_in_direction(direction = Vector2()):
	var target = Vector2()
	target.x = (direction.x-direction.y)*(-22)
	target.y = (direction.x+direction.y)*(-13)
	$Path2D.updatePath(target)
	#$Path2D.curve = updatePath(GM.currentBoard.cell_to_grid(currentCell+direction))
#	$Path2D.curve.add_point(global_position)
#	$Path2D.curve.add_point(GM.currentBoard.cell_to_grid(currentCell+direction))
	$AnimationPlayer.play("jump")
	pass

func jumpComplete():
	var targetPosition = $Path2D/PathFollow2D.global_position
	$Path2D/PathFollow2D.unit_offset = 0
	global_position=targetPosition
	update_current_cell()
	pass


func explode():
	$AnimationPlayer.play("boom")
	pass


func _on_ZapBoy_area_entered(area):
	area.pop()
	explode()
	pass # Replace with function body.


func _on_ZapBoy_body_entered(body):
	body.pop()
	explode()
	pass # Replace with function body.


func _on_TimerMove_timeout():
	print("time to move!")
	move()
	pass # Replace with function body.
