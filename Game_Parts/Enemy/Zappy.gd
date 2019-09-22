extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ZapBoyScene = load("res://Game_Parts/Enemy/ZapBoy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$TimerSpawn.start()
	pass # Replace with function body.


func spawn():
	var tartgetSpawn = GM.currentBoard.getSpawn() 
	var newBoy = ZapBoyScene.instance()
	newBoy.global_position = tartgetSpawn.global_position
	get_parent().add_child(newBoy)
	$TimerSpawn.start(randi()%6)
	$AnimationPlayer.play("idle")
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TimerSpawn_timeout():
	$AnimationPlayer.play("zap")
	pass # Replace with function body.
