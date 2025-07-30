extends "res://jump_slider.gd"

"""3 of 4 for jump"""

signal return_to_5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	moveArrow(delta,SPEED)
	
	if(inBottom and Input.is_action_just_pressed("allInteracts")):
		if(numBounces == 1):
			SPEED*=-1
			numBounces = 0
		increment.emit()
		bottomDone = true
		inBottom = false
		$middle.visible = true
		numBounces = 0
		
	if(inMid and Input.is_action_just_pressed("allInteracts")):
		if(numBounces == 1):
			SPEED*=-1
			numBounces = 0
		increment.emit()
		midDone = true
		inMid = false
		$top.visible = true
		numBounces = 0
		
	if(inTop and Input.is_action_just_pressed("allInteracts")):
		increment.emit()
		return_to_5.emit()
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

func _on_jump_slider_5_activate_slider_6():
	self.SPEED = -27000
	$".".visible = true
