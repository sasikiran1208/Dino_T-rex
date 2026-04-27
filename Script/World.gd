extends Node2D
var day = true
var HighScore
var time = 0.1
var skor = 0
@export var multiplexer = 1.005
var obstacles_speed = 576
var add_speed = 0
var SceneStart = false
var Alive = true
@export var scrollspeed = 500
func _ready(): 
	var random_time = randf_range(30,40)
	$Day.set_wait_time(random_time)
	readdata()
	
func savedata() :
	var opendir = FileAccess.open("user://DinoHS", FileAccess.WRITE)
	opendir.store_32(HighScore)
		

func readdata() :
	var opendir = FileAccess.open("user://DinoHS", FileAccess.READ)
	if opendir != null :
		HighScore = opendir.get_32()
		$UI.HighScore(HighScore)
	else :
		HighScore = 0
		$UI.HighScore(HighScore)
		
func _process(delta): 
	if Input.is_action_just_pressed("Restart") and Alive == false :
		get_tree().reload_current_scene()
		
	if Input.is_action_pressed("Jump") :
		if SceneStart == false and Alive == true:
			SceneStart = true
			$Day.start()
			$Timer.start()
			$Skor.start()
			get_node("Random Spawner/Timer").start()
			get_node("UI/AnimationPlayer").stop()
			get_node("UI/Jump").visible = false
			get_node("UI/Bow").visible = false
	
	if SceneStart == true :
		$Background/ParallaxBackground.scroll_base_offset.x -= scrollspeed * delta
		
func UpdateHS() :
	if skor > HighScore :
		HighScore = skor
		savedata()
		$UI.HighScore(HighScore)
	
func _on_dino_dino_die():
	get_node("UI/Game Over UI").visible = true
	var Obstacle = get_node("Random Spawner/Container").get_children()
	$"Random Spawner".condition = false
	for Everything in Obstacle :
			Everything.condition = false
	SceneStart = false
	Alive = false
	$AudioStreamPlayer2D.play()
	$Timer.stop()
	$Day.stop()
	$Skor.stop()
	get_node("Random Spawner/Timer").stop()
	$Ground.DC()
	UpdateHS()

func _on_timer_timeout():
	scrollspeed *= multiplexer
	time *= 0.995
	$Ground.changespeed(multiplexer)
	$"Random Spawner".changespeed(multiplexer)
	$Skor.set_wait_time(time)

func _on_skor_timeout():
	skor += 1
	$UI.score(skor)
	

func _on_day_timeout():
	var random_time = randf_range(30,40)
	$Day.set_wait_time(random_time)
	if day == true :
		$AnimationPlayer.play("DayNight")
		day = false
	elif day == false :
		$AnimationPlayer.play("NightDay")
		day = true
