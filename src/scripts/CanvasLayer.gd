extends CanvasLayer

onready var recipeContainer = $HBoxContainer

var nbIngredients = 3
var checks = []

func _ready():
	createRecipe()

func createRecipe():
	for i in nbIngredients:
		var random: int = randi() % Globals.ingredientSprites.size()
		Globals.currentRecipe.append(random)
		addIngredientIndicator(random)

func toggleCheck(ingredientID: int):
	if ingredientID > Globals.ingredientSprites.size() or ingredientID < 0:
		return
	checks[Globals.currentRecipe.find(ingredientID)].visible = true

func addIngredientIndicator(id: int):
	var ingredientIndicator = TextureRect.new()
	var ingredientCheck = TextureRect.new()
	
	ingredientIndicator.expand = true
	ingredientIndicator.rect_min_size = Vector2(50,50)
	ingredientIndicator.rect_size = Vector2(50,50)
	ingredientIndicator.texture = load(Globals.ingredientSprites[id])
	
	ingredientCheck.expand = true
	ingredientCheck.rect_min_size = Vector2(50,50)
	ingredientCheck.rect_size = Vector2(50,50)
	ingredientCheck.texture = load("res://assets/sprites/check.png")
	ingredientCheck.visible = false
	
	checks.append(ingredientCheck)
	ingredientIndicator.add_child(ingredientCheck)
	recipeContainer.add_child(ingredientIndicator)
