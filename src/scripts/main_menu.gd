extends Control

onready var ingredientScene = preload("res://src/nodes/menu_ingredient.tscn")

func _ready():
	$AnimationTree.active = true

func spawn_ingredients():
	var to_spawn = randi() % 5 + 1
	var pos_start = $Node2D/Ingredients/Start.position
	var pos_end = $Node2D/Ingredients/End.position
	for _i in range(to_spawn):
		var new_ingredient = ingredientScene.instance()
		var pos_x = rand_range(pos_start.x, pos_end.x)
		var pos_y = rand_range(-120, -60)
		new_ingredient.position = Vector2(pos_x, pos_y)
		$Node2D/Ingredients.add_child(new_ingredient)

func _on_Dispawn_body_entered(body: Node):
	body.queue_free()

func _on_Start_mouse_entered():
	$Start.modulate = Color("dddddd")

func _on_Start_mouse_exited():
	$Start.modulate = Color.white

func _on_Drop_mouse_entered():
	$Drop.modulate = Color("dddddd")

func _on_Drop_mouse_exited():
	$Drop.modulate = Color.white

func _on_Start_button_down():
	$AnimationPlayer.play("Start Btn")

func _on_Start_button_up():
	$AnimationPlayer.play_backwards("Start Btn")
	Globals.goto_scene("game")

func _on_Drop_button_down():
	$AnimationPlayer.play("Rain Btn")

func _on_Drop_button_up():
	$AnimationPlayer.play_backwards("Rain Btn")
	spawn_ingredients()
