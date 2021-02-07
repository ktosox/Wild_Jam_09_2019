extends CanvasLayer




# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


func update_enemy():
	if $EnemyValue.text != String(GM.enemyCount) :
		$EnemyValue.text = String(GM.enemyCount)
	pass

func update_HP():
	if $HPValue.text != String(GM.playerHP) :
		$HPValue.text = String(GM.playerHP)
	pass

func update_level():
	if $LevelValue.text != String(GM.currentLevel) :
		$LevelValue.text = String(GM.currentLevel)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_enemy()
	update_HP()
	update_level()
	pass

