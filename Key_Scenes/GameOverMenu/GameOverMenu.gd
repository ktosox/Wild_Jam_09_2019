extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
#	var player = AudioStreamPlayer.new()
#	self.add_child(player)
#	player.stream = load("res://Resources/Sound/SFX/Player_Death.wav")
#	player.set_bus("SFX")
#	player.set_volume_db(-6.0)
#	player.play()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_GameOverButton_pressed():
	get_tree().paused = false
	GM.resetLevel()
	
	pass # Replace with function body.


func _on_GameOverButton3_pressed():
	#get_tree().quit()
	$ColorRect.modulate.a = 1.0
	$Panel.queue_free()
	pass # Replace with function body.
