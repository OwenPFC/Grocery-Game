extends Node2D

@export var SPEED:int
@export var numBounces:int

var successfulHits

signal increment

#var numBounces = 0

var successfulHit = 0

var inTop = false
var inMid = false
var inBottom = false

var topDone = false
var midDone = false
var bottomDone = false

"""Use the timeshit to track how many times there's been a bounce, so it hits the top, that's one, then
the bottom, that's 2, then when it hits 2 you fail. So you get a full pass and technically 2 chances

THIS HAS TO GO INTO THE SLIDER SCENE"""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
		pass
		
func moveArrow(delta,speed):
	$arrow.move_and_slide()
	$arrow.velocity.y = speed*delta
	
func moveArrowHorizontally(delta,speed):
	$arrow.move_and_slide()
	$arrow.velocity.x = speed*delta
	
func _on_top_boundary_body_entered(_body):
	SPEED*=-1
	numBounces+=1

func _on_bottom_boundary_body_entered(_body):
	SPEED*=-1
	numBounces+=1
	
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
	
func _on_middle_body_entered(_body):
	if($middle.visible and !midDone):
		inMid = true

func _on_middle_body_exited(_body):
	inMid = false
