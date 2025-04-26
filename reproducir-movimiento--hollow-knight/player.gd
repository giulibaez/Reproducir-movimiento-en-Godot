extends CharacterBody2D

@export var speed: int
@export var jumpSpeed: int 
var gravity= ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	MoveX()
	Jump(delta)
	move_and_slide()
	
	
func MoveX():
	var InputGetAxis = Input.get_axis("move_left","move_right")
	velocity.x= InputGetAxis * speed

func Jump(delta):
	if Input.is_action_just_pressed("jump")and is_on_floor():
		velocity.y = -jumpSpeed
	
	if not is_on_floor():
		velocity.y += gravity * delta
