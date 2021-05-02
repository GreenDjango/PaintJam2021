extends Node

var ingredientSprites := [
	"res://assets/sprites/cheese.png",
	"res://assets/sprites/chicken.png",
	"res://assets/sprites/flour.png",
	"res://assets/sprites/mushroom.png",
	"res://assets/sprites/onion.png",
	"res://assets/sprites/tomato.png",
	"res://assets/sprites/water.png"
]

var default_life := 3.0
var life := default_life

var currentRecipe: Array = []

func _ready():
	randomize()

func restart_game():
	life = default_life
	goto_scene("main_menu")

func goto_scene(new_scene_name : String):
	TransitionsAl.next_scene("res://src/scenes/" + new_scene_name + ".tscn")
