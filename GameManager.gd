extends Node



var currentCamera
#screenShake(time)
#fadeOut(time)
#fadeIn(time)
#colorSplash(time, color)


var currentPlayer

var currentBoard

var currentLevel = 1

var introPath = "res://Key_Scenes/Intro/Intro.tscn"

var creditsPath = "res://Key_Scenes/Credits/Credits.tscn"

var mainMenuPath = "res://Key_Scenes/MainMenu/MainMenu.tscn"

var gamePath = "res://Key_Scenes/Game/Game.tscn"

var pauseMenuScene = load("res://Game_Parts/PauseMenu/PauseMenu.tscn")

var gameOverMenuScene = load("res://Game_Parts/GameOverMenu/GameOverMenu.tscn")

func _ready():

	pass

func changeToMainMenu():
	get_tree().change_scene(mainMenuPath)

func changeToGame():
	get_tree().change_scene(gamePath)
	
func changeToCredits():
	get_tree().change_scene(creditsPath)
	
func changeToIntro():
	get_tree().change_scene(introPath)
	
func pause_game():
	var newPauseMenu = pauseMenuScene.instance()
	currentCamera.add_child(newPauseMenu)
	get_tree().paused = true


func lose_game():
	var newGameOverMenu = gameOverMenuScene.instance()
	currentCamera.add_child(newGameOverMenu)
	get_tree().paused = true

func win_game(caller):
	currentLevel+=1
	changeToGame()
	caller.free()
	#ends current level and ptogresses player to next level
	#called by Game scene upon player reaching objective
	pass
	
func end_program():
	get_tree().quit()
	pass