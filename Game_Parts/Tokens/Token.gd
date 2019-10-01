extends Area2D

var parentSpawner

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

func random_fire_data():
	fireData[0] = (randi()%3)+1
	fireData[1] = (randi()%4)+2
	fireData[2] = (randi()%3)+1
	fireData[3] = (randi()%9)+7 - fireData[0]
	fireData[4] = Color(randf(),randf(),randf(),1.0)

func fixLocation():
	global_position = GM.currentBoard.global_to_grid(global_position)

func _on_Token_area_entered(area):
	area.grabToken(fireData)
	parentSpawner.loseToken()
	queue_free()
