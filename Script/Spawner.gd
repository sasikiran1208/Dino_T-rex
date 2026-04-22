extends Node2D
var condition = true
var obstacles_speed = 576
@export var RandomScene : Array[PackedScene] = []
signal Things(THINGSID)

func _process(delta):
	if condition == true :
		for x in $Container.get_children() :
			x.global_position.x -= obstacles_speed * delta

	
func Spawn() :
	var Obstacle = RandomScene.pick_random()
	var Obstacles = Obstacle.instantiate()
	var random_timer = randf_range(0.8,1)
	$Timer.set_wait_time(random_timer)
	var random_number = randi_range(1,5)
	var random_Y = randf_range(250,400)
	if Obstacles.name.begins_with("Tree") or ("Barrel"):
		Obstacles.global_position = Vector2(1260,515)
	if Obstacles.name.begins_with("Rock"):
		Obstacles.global_position = Vector2(1260,540)
	if Obstacles.name.begins_with("Bird") :
		Obstacles.global_position = Vector2(1260, random_Y)
	if random_number == 3 :
			var SecIObs = Obstacle.instantiate()
			if SecIObs.name.begins_with("Tree") :
				SecIObs.global_position = Vector2(1400,525)
				SecIObs.set_z_index(1)
				SecIObs.scale = Vector2(1.8,1.8)
				Obstacles.scale = Vector2(2,2)
			if SecIObs.name.begins_with("Barrel") :
				SecIObs.global_position = Vector2(1370,520)
				SecIObs.scale = Vector2(3.7,3.7)
				Obstacles.scale = Vector2(4,4)
			if SecIObs.name.begins_with("Rock") :
				SecIObs.global_position = Vector2(1360,randf_range(540,550))
				SecIObs.scale = Vector2(1.5,1.5)
				Obstacles.scale = Vector2(2,2)
			if SecIObs.name.begins_with("Bird") :
				SecIObs.global_position = Vector2(1350,randf_range(300,400))
				SecIObs.scale = Vector2(3,3)
				Obstacles.scale = Vector2(3,3)
			$Container.add_child(SecIObs)
	$Container.add_child(Obstacles)
	

func _on_timer_timeout():
	Spawn()
	

func changespeed(ratio) :
	obstacles_speed *= ratio
