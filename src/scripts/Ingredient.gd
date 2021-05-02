extends Node2D

onready var sprite: Sprite = $Sprite

var ingredientID: int
var selected = false
var isMoving = true

func _ready():
	initTextureRandomly()

func initTextureRandomly():
	var random = randi() % Globals.ingredientSprites.size()
	ingredientID = random
	sprite.texture = load(Globals.ingredientSprites[random])

func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(),25 * delta)
	if isMoving:
		translate(Vector2(1.8,0))

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected = false

func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("left_click"):
		selected = true
