extends levelScript

@onready var dialogue = $textbox/textbox_text

"""
So here's what's going to happen:

There will be maybe 4 freezers, one will have the blue hat,
the others will have some dialogue about whats inside

I'm not sure how to structure this because I need to make the change at both the top and side,
and ALSO animations and textboxes (teehee) which means I need to handle this at the very top level,
and I also have to change how I load in my textbox assets (probably make a getter in the level)
"""

signal pauseGGTop(isPaused:bool)

var choiceBox = load("res://TextBox2.png")
var textBoxHat = load("res://TextBox2HatTransparent.png")

var isTalking = false
var text = ["start","Hmmm", "What's this?", "WHAT", "I'M BLUE", "!"]
var text2 = ["start","I'm cool as a damn cucumber now", "!"]
var numInteractions = 0
var letterIndex = 0
var activeList = text

signal changeToBlue
# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.color == "pink":
		$textbox.texture = load("res://TextBox2HatTransparent.png")
	else: 
		var pathName = "res://textbox variants/" + Global.color + ".png"
		textBoxHat = load(pathName)
		$textbox.texture = textBoxHat
	if Global.color == "Blue":
		activeList = text2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("Interact") or Input.is_action_just_pressed("Interact_Click"))and $hat_freezer/hat_freezer_indicator.visible:
		$hat_freezer/hat_freezer_indicator.visible = false
		isTalking = true
		$textbox.visible = true
	
	"""Need the whole pause ggTop signal going"""
	if isTalking:
		pauseGGTop.emit(true)
		if(Input.is_action_just_pressed("Interact") and $textbox.visible):
			numInteractions = numInteractions+1
			dialogue.text = ""
			letterIndex = 0
		if(numInteractions<len(activeList)):
			if(letterIndex<len(activeList[numInteractions])):
				dialogue.text = dialogue.text + activeList[numInteractions][letterIndex]
				letterIndex = letterIndex+1
	
	if dialogue.text == "WHAT":
		Global.color = "Blue"
		changeToBlue.emit()
		$textbox.texture = theLevel.blueBoxHat
	if dialogue.text == "!":
		isTalking = false
		$textbox.visible = false
		activeList = text2
		dialogue.text = ""
		numInteractions = 0
		letterIndex = 0
		pauseGGTop.emit(false)

func _on_hat_freezer_action_area_body_entered(body):
	$hat_freezer/hat_freezer_indicator.visible = true

func _on_hat_freezer_action_area_body_exited(body):
		$hat_freezer/hat_freezer_indicator.visible = false
		pauseGGTop.emit(false)
		isTalking = false
