extends Control
var cv = false
var time = 0
var blink_score = 0
var condition = false
func _ready():
	$Score.text = "00000000"

func score(UpdateScore) :
	if condition == false :
		$Score.text = str(UpdateScore).pad_zeros(8)
	if UpdateScore % 100 == 0 and UpdateScore > 0 :
		blink_score = UpdateScore
		$Score.text = str(blink_score).pad_zeros(8)
		condition = true
		$Timer.start()
		$AudioStreamPlayer2D.play()
		

func HighScore(UpdateHS) :
	$HighScore.text = "HI " + str(UpdateHS).pad_zeros(8)
func _on_timer_timeout():
	time += 0.2
	if time >= 1.8 :
		time = 0
		$Timer.stop()
		condition = false
		$Score.visible = true
		

	if cv == true and condition == true :
		$Score.visible = true
		cv = false
	elif cv == false and condition == true:
		$Score.visible = false
		cv = true
	
