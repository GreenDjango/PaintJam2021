extends CanvasLayer

onready var recipeContainer = $IngredientIndicators
onready var livesContainer = $Lives
onready var addScoreLabel = $addScoreLabel

onready var timerLabel = $Timer
onready var timer = $Timer/Timer
onready var scoreTimer = $addScoreLabel/Timer

var nbIngredients = 3
var ingredientsRemaining = nbIngredients

var checks = []
var crosses = []



func _ready():
	createRecipe()
	initLives()
	
	scoreTimer.connect("timeout",self,"_on_scoreTimer_timeout")
	timer.connect("timeout",self,"_on_timer_timeout")
	timer.wait_time = 30
	timer.start()

func _process(delta):
	if ingredientsRemaining == 0:
		Globals.recipeDone = true
		if Globals.recipeDone:
			Globals.totalScore += Globals.currentScore
			print(Globals.totalScore)
			addScoreLabel.visible = true
			if Globals.currentScore < 0:
				addScoreLabel.text = "" + String(Globals.currentScore)
			else:
				addScoreLabel.text = "+" + String(Globals.currentScore)
			Globals.numberOfRecipes += 1
			if Globals.numberOfRecipes == 3:
				timer.wait_time -= 5
				Globals.numberOfRecipes = 0
			scoreTimer.wait_time = 3
			scoreTimer.start()
			Globals.currentScore = 30
			changeRecipe()
	timerLabel.text = String(int(timer.time_left))

func _on_timer_timeout():
	if not Globals.recipeDone:
		crosses[Globals.life-1].visible = true
		Globals.life -= 1
		Globals.numberOfRecipes += 1
		if Globals.numberOfRecipes == 3:
			timer.wait_time -= 5
			Globals.numberOfRecipes = 0
		if Globals.life ==  0:
			Globals.goto_scene("retry_menu")
		changeRecipe()

func _on_scoreTimer_timeout():
	addScoreLabel.visible = false

func changeRecipe():
	timer.start()
	checks = []
	Globals.currentRecipe = []
	Globals.recipeDone = false
	ingredientsRemaining = nbIngredients
	for child in recipeContainer.get_children():
		child.queue_free()
	createRecipe()
	recipeContainer

func createRecipe():
	for i in nbIngredients:
		var random: int = randi() % Globals.ingredientSprites.size()
		if Globals.currentRecipe.has(random):
			while Globals.currentRecipe.has(random):
				random = randi() % Globals.ingredientSprites.size()
		Globals.currentRecipe.append(random)
		addIngredientIndicator(random)

func initLives():
	for i in Globals.default_life:
		addLives()

func toggleCheck(ingredientID: int):
	if ingredientID > Globals.ingredientSprites.size() or ingredientID < 0:
		return
	checks[Globals.currentRecipe.find(ingredientID)].visible = true

func removeLife():
	crosses[Globals.life-1].visible = true
	Globals.life -= 1

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

func addLives():
	var liveIndicator = TextureRect.new()
	var liveCross = TextureRect.new()
	
	liveIndicator.expand = true
	liveIndicator.rect_min_size = Vector2(50,50)
	liveIndicator.rect_size = Vector2(50,50)
	liveIndicator.texture = load("res://assets/sprites/campbells.png")
	liveIndicator.modulate = Color.lightgray
	
	liveCross.expand = true
	liveCross.rect_min_size = Vector2(50,50)
	liveCross.rect_size = Vector2(50,50)
	liveCross.texture = load("res://assets/sprites/cross.png")
	liveIndicator.self_modulate = Color.white
	liveCross.visible = false
	
	crosses.append(liveCross)
	liveIndicator.add_child(liveCross)
	livesContainer.add_child(liveIndicator)
