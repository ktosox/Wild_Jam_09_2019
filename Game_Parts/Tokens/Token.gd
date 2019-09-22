extends Area2D

var fireData = [
0,
0,
0,
0,
Color()
]

func _ready():
	randomize()
	fixLocation()
	random_fire_data()
	modulate=fireData[4]
	pass # Replace with function body.

func random_fire_data():
	fireData[0] = (randi()%3)+1
	fireData[1] = (randi()%4)+2
	fireData[2] = (randi()%3)+1
	fireData[3] = (randi()%9)+7 - fireData[0]
	fireData[4] = Color(randf(),randf(),randf(),1.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func fixLocation():
	global_position = GM.currentBoard.global_to_grid(global_position)

func _on_Token_area_entered(area):
	area.grabToken(fireData)
	queue_free()
	pass # Replace with function body.
