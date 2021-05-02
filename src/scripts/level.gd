extends Node2D

onready var spawn_ingredient = $SpawnIngredient
onready var ingredient = preload("res://src/nodes/Ingredient.tscn")

var ingredientsInstancied = []
var ingredientDragged = null
var isIngredientInDespositArea = false

func _ready():
	instanceIngredient()

func _physics_process(delta):
	if isIngredientInDespositArea and not Input.is_mouse_button_pressed(BUTTON_LEFT):
		ingredientDragged.queue_free()

func _on_DepositArea_area_entered(area):
	var ingredient = area.get_node("../../") # Getting the Ingredient node
	if ingredient.is_in_group("Item") :
		isIngredientInDespositArea = true
		ingredientDragged = ingredient

func _on_DepositArea_area_exited(area):
	var ingredient = area.get_node("../../") # Getting the Ingredient node
	if ingredient.is_in_group("Item") :
		isIngredientInDespositArea = false
		ingredientDragged = null

func _on_DispawnIngredient_area_entered(area):
	var ingredient = area.get_node("../../") # Getting the Ingredient node
	if ingredient.is_in_group("Item") :
		ingredient.queue_free()

func instanceIngredient():
	var new_ingredient = ingredient.instance()
	new_ingredient.position = spawn_ingredient.position
	add_child(new_ingredient)
	ingredientsInstancied.append(new_ingredient)

