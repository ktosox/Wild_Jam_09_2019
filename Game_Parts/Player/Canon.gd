extends Node2D

var blastScene = load("res://Game_Parts/Player/Blast.tscn")
var barrageScene = load("res://Game_Parts/Player/Barrage.tscn")

var bulletScene = load("res://Game_Parts/Player/PlayerBullet.tscn")

var projectileSpeed = 200

func _physics_process(delta):
	rotation = atan2( global_position.x - get_global_mouse_position().x , -global_position.y + get_global_mouse_position().y ) #- self.rotation


func fire_canon(fireData):
	match(fireData[2]):
		1:
			fireBarrage(fireData)
		2:
			fireBlast(fireData)
		3:
			fireLazor(fireData)


func fire_bullet():
	var bullet = bulletScene.instance()
	bullet.global_position = $Muzzle.global_position
	bullet.direction = Vector2(sin(rotation),-cos(rotation)) * -1
	get_parent().get_parent().add_child(bullet) #this needs a clean up

func fireBlast(fireData):
	var blast = blastScene.instance()
	blast.global_position=$Muzzle.global_position
#	var direction = get_parent().currentDirection
#	blast.linear_velocity.y = (direction.x+direction.y) * (-65)
#	blast.linear_velocity.x = (direction.x-direction.y) * (-110)
	blast.linear_velocity = projectileSpeed * Vector2(sin(rotation),-cos(rotation)) * -1
	blast.modulate = fireData[4]
	blast.lifetime = fireData[1]+4
	get_parent().get_parent().add_child(blast)
	pass
	
func fireBarrage(fireData):
	var barrage = barrageScene.instance()
	barrage.global_position=$Muzzle.global_position
#	var direction = get_parent().currentDirection
#	barrage.linear_velocity.y =( (direction.x+direction.y) * (-26) ) + (-13 + randi()%26 )
#	barrage.linear_velocity.x =( (direction.x-direction.y) * (-44) ) + (-22 + randi()%44 )
	barrage.linear_velocity = projectileSpeed * Vector2(sin(rotation),-cos(rotation)) * -1
	barrage.modulate = fireData[4]
	barrage.lifetime = fireData[1]+4
	get_parent().get_parent().add_child(barrage)
	pass
	
func fireLazor(fireData):
	$Node2D.modulate=fireData[4]
	$Node2D.scale.x = fireData[1] * 0.2
	$Node2D/AnimationPlayer.play("fire")
	pass


