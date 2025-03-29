extends Node2D

var colors = ["beige","brown","green","orange","pink","salami","yellow"]
var colorIndex = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$slicer.play("speen")
	$guy.play("crying")
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(colorIndex > 6):
		colorIndex = 0
#This is just making a little 1/10 chance thing
	if((randi_range(0,500) == 5) and $guy.animation=="crying"):
		$guy.animation = "grab"
		$guy.play("grab")
	elif($guy.animation == "grab" and $guy.frame == 6):
		$guy.animation = colors[colorIndex]
		$guy.play(colors[colorIndex])
		colorIndex+=1
	elif($guy.animation in colors and $guy.frame == 11):
		$guy.animation = "crying"
		$guy.play("crying")
		
