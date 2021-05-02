extends Node

var ingredientSprites := [
	"res://assets/sprites/cheese.png",
	"res://assets/sprites/chicken.png",
	"res://assets/sprites/flour.png",
	"res://assets/sprites/mushroom.png",
	"res://assets/sprites/onion.png",
	"res://assets/sprites/tomato.png",
	"res://assets/sprites/water.png",
	"res://assets/sprites/egg.png",
	"res://assets/sprites/meat.png",
	"res://assets/sprites/noodles.png",
	"res://assets/sprites/pepper.png",
	"res://assets/sprites/salad.png",
	"res://assets/sprites/salt.png",
	"res://assets/sprites/spice.png",
	"res://assets/sprites/butter.png"
]

var default_life := 3.0
var life := default_life

var currentRecipe: Array = []
var recipeDone = false

var lastPosition = null
var dragging = false
var ingredientDragged = null
var ingredientSpeed = 3

var totalScore: int = 0
var currentScore: int = 30

var numberOfRecipes = 0 #To increase difficulty

func _ready():
	randomize()

func restart_game():
	life = default_life
	goto_scene("main_menu")

func goto_scene(new_scene_name : String):
	TransitionsAl.next_scene("res://src/scenes/" + new_scene_name + ".tscn")
