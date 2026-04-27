extends StaticBody2D
var object_speed = 576
var alive = true
var condition = false
func _process(delta):
	if Input.is_action_pressed("Jump") and alive == true:
		condition = true
	if condition == true :
		$ParallaxBackground.scroll_base_offset.x -= object_speed * delta
		
	
func DC() :
	alive = false
	condition = false
	
func changespeed(ratio) :
	object_speed *= ratio
