extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hasToken = false

var tokenScene = load("res://Game_Parts/Tokens/Token.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	fixLocation()
	$TimerCooldown.start(randi()%9)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func loseToken():
	$nest1.visible = true
	hasToken = false
	$TimerCooldown.start()

func fixLocation():
	global_position = GM.currentBoard.global_to_grid(global_position)

func spawnToken():
	$nest1.visible = false
	var newToken  = tokenScene.instance()
	newToken.global_position = global_position
	newToken.parentSpawner = self
	get_parent().add_child(newToken)
	hasToken = true
	pass

func _on_TimerCooldown_timeout():
	if(hasToken == false):
		spawnToken()
	pass # Replace with function body.
