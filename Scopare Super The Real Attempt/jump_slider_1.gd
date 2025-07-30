extends "res://jump_slider.gd"

"""Main"""

#20000


signal activate_slide_2()
signal activate_slide_4
signal activate_slide_8

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	super.moveArrow(delta,SPEED)
	
	if(inBottom and Input.is_action_just_pressed("allInteracts")):
		print(numBounces)
		increment.emit()
		self.SPEED = 0
		bottomDone = true
		inBottom = false
		activate_slide_2.emit()
		numBounces = 0
		
	if(inMid and Input.is_action_just_pressed("allInteracts")):
		print(numBounces)
		increment.emit()
		self.SPEED = 0
		midDone = true
		inMid = false
		activate_slide_4.emit()
		numBounces = 0
		
	if(inTop and Input.is_action_just_pressed("allInteracts")):
		increment.emit()
		self.SPEED = 0
		topDone = true
		inTop = false
		activate_slide_8.emit()
		numBounces = 0
		
func _on_top_body_entered(_body):
	if($top.visible and !topDone):
		inTop = true

func _on_top_body_exited(_body):
	inTop = false
	
func _on_bottom_body_entered(_body):
	if(!bottomDone):
		inBottom = true

func _on_bottom_body_exited(_body):
	inBottom = false

func _on_jump_slider_2_return_to_1():
	self.SPEED = -20000
	$middle.visible = true


func _on_middle_body_entered(_body):
	if($middle.visible and !midDone):
		inMid = true


func _on_middle_body_exited(_body):
	inMid = false

func _on_jump_slider_4_return_to_1():
	self.SPEED = -20000
	$top.visible = true


func _on_jump_slider_8_return_to_1():
	queue_free()
