extends Control

onready var scoreLabel = $Title/Score

func _ready():
	scoreLabel.text = "Your score is " + String(Globals.totalScore)
	Globals.resetValues()

func _on_Quit_pressed():
	Globals.goto_scene("main_menu")
