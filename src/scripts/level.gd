extends Node2D

onready var ConvoyerBelt1 := $ConvoyerBelt/ConvoyerBelt1
onready var ConvoyerBelt2 := $ConvoyerBelt/ConvoyerBelt2
onready var ConvoyerBelt3 := $ConvoyerBelt/ConvoyerBelt3
onready var ConvoyerOrder := [ConvoyerBelt1, ConvoyerBelt2, ConvoyerBelt3]
onready var ConvoyerSize : Vector2 = ConvoyerBelt1.texture.get_size()

var ConvoyerSpeed = 180
var speedLevel = 1

onready var spawn_ingredient = $SpawnIngredient
onready var ingredientScene = preload("res://src/nodes/Ingredient.tscn")
var spawnSpeed = 2

var timer = 0
var ingredientsInstancied = []
var isIngredientInDespositArea = false

func _ready():
	instanceIngredient()

func _process(delta):
	var convFirst : Sprite = ConvoyerOrder[0]
	var convLast : Sprite = ConvoyerOrder[-1]
	convFirst.position.x += delta * ConvoyerSpeed
	if convFirst.position.x >= get_viewport().size.x:
		convFirst.position.x = 0
	if convFirst.position.x >= 0:
		convLast.position = convFirst.position - Vector2(ConvoyerSize.x, 0)
		ConvoyerOrder.pop_back()
		ConvoyerOrder.push_front(convLast)
	convFirst = ConvoyerOrder[0]
	convLast = ConvoyerOrder[-1]
	for convID in range(1, ConvoyerOrder.size()):
		ConvoyerOrder[convID].position = ConvoyerOrder[convID - 1].position + Vector2(ConvoyerBelt1.texture.get_size().x, 0)

func _physics_process(delta):
	timer += delta
	if timer >= spawnSpeed:
		instanceIngredient()
		timer = 0
	
	if not Input.is_mouse_button_pressed(BUTTON_LEFT):
		var UI = get_tree().get_nodes_in_group("UI")[0]
		if isIngredientInDespositArea:
			if Globals.currentRecipe.has(Globals.ingredientDragged.ingredientID):
				UI.toggleCheck(Globals.ingredientDragged.ingredientID)
				UI.ingredientsRemaining -= 1
			else:
				Globals.currentScore -= 10
			Globals.ingredientDragged.queue_free()
			Globals.ingredientDragged = null
		else:
			if Globals.ingredientDragged != null:
				Globals.ingredientDragged.position = Globals.lastPosition
				Globals.ingredientDragged = null


func _on_DepositArea_area_entered(area):
	var ingredient = area.get_node("../../") # Getting the Ingredient node
	if ingredient.is_in_group("Item") :
		isIngredientInDespositArea = true

func _on_DepositArea_area_exited(area):
	var ingredient = area.get_node("../../") # Getting the Ingredient node
	if ingredient.is_in_group("Item") :
		isIngredientInDespositArea = false

func _on_DispawnIngredient_area_entered(area):
	var ingredient = area.get_node("../../") # Getting the Ingredient node
	if ingredient.is_in_group("Item") :
		ingredient.queue_free()

func instanceIngredient():
	var new_ingredient = ingredientScene.instance()
	new_ingredient.position = spawn_ingredient.position
	add_child(new_ingredient)
	ingredientsInstancied.append(new_ingredient)

func _on_SpeedDown_pressed():
	if speedLevel == 1:
		return
	speedLevel -= 1
	updateSpeed()

func _on_SpeedUp_pressed():
	if speedLevel == 3:
		return
	speedLevel += 1
	updateSpeed()

func updateSpeed():
	match speedLevel:
		1:
			ConvoyerSpeed = 180
			Globals.ingredientSpeed =  3
			spawnSpeed = 2
		2:
			ConvoyerSpeed = 360
			Globals.ingredientSpeed =  6
			spawnSpeed = 1
		3:
			ConvoyerSpeed = 720
			Globals.ingredientSpeed =  12
			spawnSpeed = 0.5
