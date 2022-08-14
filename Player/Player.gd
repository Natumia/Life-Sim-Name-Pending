extends KinematicBody2D

onready var interaction_ray = $InteractionRay

var velocity = Vector2.ZERO

var maxHealth: int = 10

var health: int = 10
var speed: int = 100

func _ready():
	pass

func _physics_process(_delta):
	player_input()
	movement()

func player_input():
	var inputVelocity = Vector2.ZERO
	inputVelocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputVelocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	velocity = inputVelocity
	velocity = velocity.normalized() * speed
	
	if Input.is_action_just_pressed("ui_accept"):
		var object = interaction_ray.get_collider()
		
		if object != null and object.is_in_group("Interactable"):
			object.interact()

func movement():
	velocity = move_and_slide(velocity)

func player_pause(state):
	set_physics_process(state)
	set_process(state)
	set_process_input(state)
