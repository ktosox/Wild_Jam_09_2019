extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var startCell = Vector2()
var lifetime

# Called when the node enters the scene tree for the first time.
func _ready():
	startCell = GM.currentBoard.world_to_map(global_position)
	pass # Replace with function body.

func updateZ():
	z_index=GM.currentBoard.world_to_map(global_position).x+GM.currentBoard.world_to_map(global_position).y

func _physics_process(delta):
	updateZ()
	if(startCell.distance_to(GM.currentBoard.world_to_map(global_position))>lifetime):
		$HitSound.volume_db = -60
		pop()
	pass

func pop():
	$Sprite.visible = false
	linear_velocity = Vector2()
	$HitSound.play()
	#$CPUParticles2D.emitting = true
	$TimerDie.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TimerDie_timeout():
	queue_free()
	pass # Replace with function body.
