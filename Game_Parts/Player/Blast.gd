extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func pop():
	$Sprite.visible = false
	linear_velocity = Vector2()
	#$CPUParticles2D.emitting = true
	$TimerDie.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TimerDie_timeout():
	queue_free()
	pass # Replace with function body.
