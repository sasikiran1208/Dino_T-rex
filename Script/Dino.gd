extends CharacterBody2D
signal DinoDie
@export var gravity = 5000
@export var JF = 95000
var Start = false
var Alive = true
func _physics_process(delta):
	if !is_on_floor() and Alive == true: #whenfall
		velocity.y += gravity * delta
		$AnimatedSprite2D.play("Jumping")
	elif !is_on_floor() and Alive == false:
		velocity.y = 0 * delta
	
	#Input
	if Input.is_action_pressed("Jump") :
		if is_on_floor() and Alive == true: #whenjump
			velocity.y = -JF * delta
			Start = true
			$AudioStreamPlayer2D.play()
			
	
	if Start == false :
		if is_on_floor() :
				$AnimatedSprite2D.play("Idle")
				
	if Start == true and Alive == true:
		if Input.is_action_pressed("Bow") :
			if is_on_floor() :
				$AnimatedSprite2D.play("Running Low")
		elif is_on_floor() :
			$AnimatedSprite2D.play("Running Normal")
			
		
	move_and_slide()
	
func DC() :
	Alive = false
	emit_signal("DinoDie")
	$AnimatedSprite2D.play("Dead")
	
