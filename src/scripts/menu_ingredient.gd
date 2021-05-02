extends RigidBody2D

onready var ingredients = [$Tomato, $Salad, $Onion, $Cheese]

func _ready():
	angular_velocity = rand_range(-15, 15)
	var ingr = randi() % ingredients.size()
	
	for i in range(ingredients.size()):
		ingredients[i].visible = false
		ingredients[i].disabled = true

	ingredients[ingr].visible = true
	ingredients[ingr].disabled = false
