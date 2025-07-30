extends "res://jump_slider.gd"

"""1 of 2 for squatting"""

signal activate_slide_3
signal return_to_1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	super.moveArrow(delta,SPEED)
	
	if(inTop and Input.is_action_just_pressed("allInteracts")):
		if(numBounces == 1):
			SPEED*=-1
			numBounces = 0
		print(numBounces)
		increment.emit()
		topDone = true
		inTop = false
		$middle.visible = true
		numBounces = 0
	
		
	if(inMid and Input.is_action_just_pressed("allInteracts")):
		increment.emit()
		midDone = true
		inMid = false
		activate_slide_3.emit()
		self.SPEED = 0
		numBounces = 0
		
	if(inBottom and Input.is_action_just_pressed("allInteracts")):
		increment.emit()
		return_to_1.emit()
		queue_free()


func _on_jump_slider_1_activate_slide_2():
	$".".visible = true
	self.SPEED = 20000


func _on_top_body_entered(_body):
	if(!topDone and $".".visible):
		inTop = true

func _on_top_body_exited(_body):
	inTop = false
	
func _on_middle_body_entered(_body):
	if(!midDone and $middle.visible):
		inMid = true


func _on_middle_body_exited(_body):
	inMid = false

func _on_jump_slider_3_return_to_2():
	$bottom.visible = true
	self.SPEED = -20000

func _on_bottom_body_entered(_body):
	if(!bottomDone and $bottom.visible):
		inBottom = true

func _on_bottom_body_exited(_body):
	inBottom = false
