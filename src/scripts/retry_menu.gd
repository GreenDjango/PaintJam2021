extends Control

onready var scoreLabel = $Title/Score

func _ready():
	Globals.resetValues()
	scoreLabel.text = "Your score is " + String(Globals.totalScore)

func _on_Retry_pressed():
	Globals.goto_scene("game")
	pass

func _on_Quit_pressed():
	Globals.goto_scene("main_menu")
	pass 
