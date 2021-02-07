extends Node2D

var enemyBodyScene = preload("res://Game_Parts/Enemy/EnemyBody.tscn")

var allEnemies = []

# Called when the node enters the scene tree for the first time.
func _ready():
	GM.currentSpawner = self
	pass # Replace with function body.

func spawn_enemy(location):
	var newEnemy = enemyBodyScene.instance()
	newEnemy.global_position = location
	get_parent().add_child(newEnemy)
	allEnemies.push_back(newEnemy)
	newEnemy.speed*= 1 + GM.currentLevel * 0.14
	pass

func spawn_wave(level):
	if (level == -1):
		return
	for t in 2 + round(GM.currentLevel/1.3) :
		spawn_enemy(pick_spawn_point())
	GM.enemyCount = allEnemies.size()
	pass

func pick_spawn_point():
	var randomSpot = GM.currentPlayer.global_position + Vector2(120,0).rotated(2*PI*randf())
	randomSpot = GM.currentBoard.get_parent().get_closest_point(randomSpot) # this is a workd arounf for accesing the navigation node which needs to be improved later on
	if(randomSpot.distance_to(GM.currentPlayer.global_position)<80):
		randomSpot = pick_spawn_point() # recuring functions without an emergency exit never go wrong, right?
	return randomSpot
	pass


func report_death(enemy):
	if !allEnemies.has(enemy) :
		print("who da hell is ",enemy,", I dont have him on my List :(")
	else:
		allEnemies.erase(enemy)
		GM.enemyCount -=1
	if(GM.enemyCount<1):
		$WaveDelay.start()
	pass

func _on_WaveDelay_timeout():
	print("starting wave from level: ",GM.currentLevel)
	spawn_wave(GM.currentLevel)
	GM.currentLevel +=1
