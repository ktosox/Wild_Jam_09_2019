extends Area2D

var direction = Vector2()
var speed = 480

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_position+=direction*speed*delta
	pass

func pop():
	die()
	pass

func _on_LifeTime_timeout():
	die()
	pass # Replace with function body.

func die():
	$CollisionShape2D.queue_free()
	$CPUParticles2D.emitting = false
	$effect4.visible = false
	speed = 0
	$DeathTimer.start()
	pass

func _on_DeathTimer_timeout():
	call_deferred("queue_free")
	pass # Replace with function body.
