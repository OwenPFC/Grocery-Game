extends "res://jump_slider.gd"

"""1 of 4 for grab"""

signal activate_slide_9
signal activate_slide_10
signal return_to_1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	moveArrowHorizontally(delta,SPEED)
	
	if(inBottom and Input.is_action_just_pressed("allInteracts")):
		increment.emit()
		bottomDone = true
		inBottom = false
		self.SPEED = 0
		activate_slide_9.emit()
		numBounces = 0
		
	if(inMid and Input.is_action_just_pressed("allInteracts")):
		increment.emit()
		midDone = true
		inMid = false
		self.SPEED = 0
		activate_slide_10.emit()
		numBounces = 0
		
	if(inTop and Input.is_action_just_pressed("allInteracts")):
		increment.emit()
		return_to_1.emit()
		queue_free()
	
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

func _on_jump_slider_1_activate_slide_8():
	$".".visible = true
	self.SPEED = -25000


func _on_jump_slider_9_return_to_slide_8():
	self.SPEED = -25000
	$middle.visible = true

func _on_jump_slider_11_return_to_8():
	self.SPEED = -29000
	$top.visible = true
