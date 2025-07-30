extends "res://jump_slider.gd"

"""3 of 4 for grab"""

signal activate_slide_11

func _physics_process(delta):
	moveArrowHorizontally(delta,SPEED)
	
	if(inBottom and Input.is_action_just_pressed("allInteracts")):
		increment.emit()
		bottomDone = true
		inBottom = false
		$middle.visible = true
		numBounces = 0
		
	if(inMid and Input.is_action_just_pressed("allInteracts")):
		increment.emit()
		midDone = true
		inMid = false
		$top.visible = true
		numBounces = 0
		
	if(inTop and Input.is_action_just_pressed("allInteracts")):
		increment.emit()
		self.SPEED = 0
		activate_slide_11.emit()
		inTop = false
		$top.monitoring = false
		#Doing this so that it stays on screen but doesn't make inputs keep happening
		#for 11
	
func _on_bottom_body_entered(_body):
	if(!bottomDone):
		inBottom = true
		
func _on_bottom_body_exited(_body):
	inBottom = false

func _on_middle_body_entered(_body):
	if(!midDone and $middle.visible):
		inMid = true

func _on_middle_body_exited(_body):
	inMid = false
	
func _on_top_body_entered(_body):
	if(!topDone and $top.visible):
		inTop = true
		
func _on_top_body_exited(_body):
	inTop = false

func _on_jump_slider_8_activate_slide_10():
	$".".visible = true
	self.SPEED = -30000

func _on_jump_slider_11_return_to_8():
	queue_free()
