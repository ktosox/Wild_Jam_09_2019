extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var direction = Vector2()

var target 

var active = false

var speed = 6930

export var speedMod = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if(active):
		apply_impulse(Vector2(),direction*speed*delta * speedMod)
	if abs(rotation) >0.4 :
		print(self, "correction")
		apply_torque_impulse(-rotation*delta*7000000)
	if($Sprite.global_rotation !=0):
		$Sprite.global_rotation = 0
	pass

func follow_player():
	pass

func attack_player():
	pass

func spawn():
	pass

func get_hit():
	call_deferred("queue_free")
	pass

func _on_UpdateDirection_timeout():
	target = GM.currentPlayer
	direction = $MovementPatternA.get_direction(target)
	pass # Replace with function body.


func _on_AggroRange_body_entered(body):
	active = true
	pass # Replace with function body.


func _on_AggroRange_area_entered(area):
	active = true
	pass # Replace with function body.


func _on_HitBox_area_entered(area):
	get_hit()
	area.pop()
	pass # Replace with function body.

func _exit_tree():
	GM.currentSpawner.report_death(self)
