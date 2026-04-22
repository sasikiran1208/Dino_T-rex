extends Area2D
var condition = true
var object_speed = 576
func _process(_delta):
	if condition == true :
		if global_position.x < -100 :
			queue_free()

func _on_body_entered(body):
	if body.name == "Dino" :
		body.DC()
		
