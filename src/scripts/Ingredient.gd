extends Node2D

onready var sprite: Sprite = $Sprite

var speed = 3

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
		translate(Vector2(Globals.ingredientSpeed,0))

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected = false
			Globals.dragging = false

func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("left_click") and not Globals.dragging:
		selected = true
		Globals.dragging = true
		Globals.ingredientDragged = self
		Globals.lastPosition = position
