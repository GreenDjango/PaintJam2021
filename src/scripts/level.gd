extends Node2D

onready var ConvoyerBelt1 = $ConvoyerBelt/ConvoyerBelt1
onready var ConvoyerBelt2 = $ConvoyerBelt/ConvoyerBelt2

onready var spawn_ingredient = $SpawnIngredient
onready var ingredient = preload("res://src/nodes/Ingredient.tscn")

var timer = 0
var ingredientsInstancied = []
var isIngredientInDespositArea = false

func _ready():
	instanceIngredient()

func _physics_process(delta):
	timer += delta
	if timer >= 2:
		instanceIngredient()
		timer = 0
	
	if not Input.is_mouse_button_pressed(BUTTON_LEFT):
		if isIngredientInDespositArea:
			print("deposit")
			if Globals.currentRecipe.has(Globals.ingredientDragged.ingredientID):
				get_tree().get_nodes_in_group("UI")[0].toggleCheck(Globals.ingredientDragged.ingredientID)
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
	var new_ingredient = ingredient.instance()
	new_ingredient.position = spawn_ingredient.position
	add_child(new_ingredient)
	ingredientsInstancied.append(new_ingredient)



func _on_SpeedNormal_pressed():
	pass # Replace with function body.

func _on_SpeedUp_pressed():
	pass # Replace with function body.
