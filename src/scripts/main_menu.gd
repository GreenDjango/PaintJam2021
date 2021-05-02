extends Control

func _ready():
	pass

func _on_Start_mouse_entered():
	$Start.modulate = Color("dddddd")

func _on_Start_mouse_exited():
	$Start.modulate = Color.white

func _on_Start_button_down():
	$AnimationPlayer.play("Start")

func _on_Start_button_up():
	$AnimationPlayer.play_backwards("Start")
	Globals.goto_scene("game")
