extends CharacterBody2D

@export var maxSpeed: int
@export var acceleration: int #que tan rapido llega a la velocidad maxima
@export var friction: int #para cuanto tarda el frenar si suelta la tecla

@export var jumpSpeed: int 
@export var maxJump: int # maximo de saltos 
var gravity= ProjectSettings.get_setting("physics/2d/default_gravity")
var jumpsLeftover = maxJump


func _physics_process(delta):
	MoveX(delta)
	Jump(delta)
	move_and_slide()
	

#movimiento con aceleracion e inercia.
func MoveX(delta):
	var InputGetAxis = Input.get_axis("move_left","move_right")
	# mueve la velocidad en x hacia la maxima velocidad usando la aceleracion como paso.
	if InputGetAxis !=0 : # si esta quieto 
		velocity.x= move_toward( velocity.x,InputGetAxis * maxSpeed,acceleration * delta) 
	else :
		velocity.x= move_toward(velocity.x,0, friction) # si no presiona nada, lo mismo que en el if jj, lleva la velocidad en x a cero usando la friccion como paso

func Jump(delta):
	if is_on_floor():
		jumpsLeftover = maxJump # si toca el piso, se reinicia loça cant de saltos juju
		
	if Input.is_action_just_pressed("jump")and jumpsLeftover >0 : # si toca la tecla asignada y ademas los saltos restantes son mayor a 0 salta
		velocity.y = - jumpSpeed
		jumpsLeftover -= 1
		
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= 0.2
	
	if not is_on_floor():
		if velocity.y < 0: # si el personaje esta subiendo
			velocity.y += gravity * delta * 0.6 # reduce el efecto de la gravedad al 60%
		else:
			velocity.y += gravity * delta * 1.5
