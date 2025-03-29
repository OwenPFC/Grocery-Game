extends levelScript

@onready var dialogue = $textbox/theText
@onready var choice1 = $choice1
@onready var choice2 = $choice2

var choiceBox = load("res://TextBox2.png")
var choiceBoxHat = load("res://TextBox2HatTransparent.png")

var goodwillCounter = 0
var badwillCounter = 0

var numInteractions = 0
var indexCount = 0

var mouseInChoice1 = false
var mouseInChoice2 = false
var mouseInConcede = false

var choice1Chosen = false
var choice2Chosen = false
var concedeChosen = false

var inChoice = false
#This has dolomite joe text for the moment
var mainText = ["How about them eagles?", "I'm just joking sorry", "So back to your point about the rocks", "I still don't really
get what seperates your rocks from their rocks?", "QUESTION?", "And honestly I'm just trying to
fill up my gravel pit", "I'm not so sure that I'm in the quality market"]

var one1Text = ["eat","shit","and","die","My brother in christ how could you say that",">:("]
var one2Text = ["eat","candy","and","live","Thanks bro I will",":)"]
var concedeText = ["Alright buddy", "You can have your meat", "Why thank you", "I'm glad you can see reason", "@"]

var activeList = mainText
var letterIndex = 0

#This is a dict for meatman idle animations
var faces = {1:"neutral",2:"flip",3:"horizontal",4:"vert"}
#Setting this initially so that his face is neutral
var faceNum = 1 
#Whether or not the previous animation ended with his mouth being closed
var mouthIsClosed = false

var meatIsTalking = true


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start(3)
	
	if Global.color == "pink":
		pass
		#$textbox.texture = load("res://TextBox2HatTransparent.png")
	else: 
		var pathName = "res://textbox variants/" + Global.color + ".png"
		var pathName2 = "res://textbox variants/" + Global.color +" 2.png"
		choiceBox = load(pathName2)
		choiceBoxHat = load(pathName)
		$choice1.icon = choiceBox
		$choice2.icon = choiceBox
		$concedeButton.icon = choiceBox


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	
	#This won't run by default because I will have specific aniamtions for when he speaks
	if(!meatIsTalking):
		######################
		print("hello") #this doesn't print currently because I don't have a make false statement yet
		#This is the code for his idle animations
		if(int($Timer.time_left) < 1):
			var previousFaceNum = faceNum
			faceNum = int(randf_range(1,4))
			print(faceNum)
			if($"meatman(animated)".frame == 0):
				mouthIsClosed = false
			elif($"meatman(animated)".frame == 3):
				print("mouth closing")
				mouthIsClosed = true
			if(faceNum == previousFaceNum and !$"meatman(animated)".is_playing()):
				if(mouthIsClosed):
					$"meatman(animated)".play_backwards(faces[faceNum])
				else:
					$"meatman(animated)".play(faces[faceNum])
				print("animation")
			elif(!$"meatman(animated)".is_playing()):
				print("change")
				$"meatman(animated)".animation = faces[faceNum]
				if(mouthIsClosed):
					$"meatman(animated)".frame = 3
				else:
					$"meatman(animated)".frame = 0
			$Timer.start(3)
		#####################
	else:
		pass
	
	
	"""
	-It may be that we want to add +1 to the index when pressing the choice buttons but i am presently unsure
	-Selecting options with left and right?? And using e to select. How would I then account for blank space if it actually
	doesn't matter at all
	"""
	
	#THIS LETS YOU CHOOSE BUTTONS WITH ARROWS
	if(Input.is_action_just_pressed("Left")):
		$choice1.grab_focus()
		$choice1.icon = choiceBoxHat
		$choice2.icon = choiceBox
		$concedeButton.icon = choiceBox
	if(Input.is_action_just_pressed("Right")):
		$choice2.grab_focus()
		$choice2.icon = choiceBoxHat
		$choice1.icon = choiceBox
		$concedeButton.icon = choiceBox
	if(Input.is_action_just_pressed("Down")):
		$concedeButton.grab_focus()
		$choice1.icon = choiceBox
		$choice2.icon = choiceBox
		$concedeButton.icon = choiceBoxHat
	
	if((Input.is_action_just_pressed("Interact") or Input.is_action_just_pressed("Interact_Click")) and mouseIsInBlankSpace() and !inChoice):
		numInteractions = numInteractions+1
		dialogue.text = ""
		letterIndex = 0
	if(numInteractions<len(activeList)):
		if(letterIndex<len(activeList[numInteractions])):
			dialogue.text = dialogue.text + activeList[numInteractions][letterIndex]
			letterIndex = letterIndex+1
	if(dialogue.text == "QUESTION?"):
		inChoice = true
		changeVisibility(true)
		choice1.text = "YOU ARE EVIL"
		choice2.text = "   Maybe you're not so bad"
		if(choice1Chosen):
			choiceMade("question1",1)
		if(choice2Chosen):
			choiceMade("question1",2)
		if(concedeChosen):
			choiceMade("question1",3)
	
	#Once the sum is equal to the number of questions asked, return to the store
	#Also make it just e since the text loads in slower, this way it will still look
	#automatic
	#it's looking for the first character of either face
	if(dialogue.text == ">" or dialogue.text == ":"):
		if(goodwillCounter+badwillCounter==1):
			if(goodwillCounter>badwillCounter):
				makeTrue("meat")
			makeTrue("negotiation")
			changeToTop()
	if(dialogue.text == "@"):
		makeTrue("negotiation")
		changeToTop()
	
func choiceMade(event:String,choice:int):
	changeVisibility(false)
	#clears dialogue so the event doesn't happen infinitely
	dialogue.text = ""
	numInteractions = 0
	letterIndex = 0
	if(event=="question1"):
		if(choice==1):
			activeList = one1Text
			choice1Chosen = false
			inChoice = false
			badwillCounter = badwillCounter+1
		elif(choice == 2):
			activeList = one2Text
			choice2Chosen = false
			inChoice = false
			goodwillCounter = goodwillCounter+1
		else:
			activeList = concedeText
			concedeChosen = false
			inChoice = false

func changeVisibility(torf:bool):
	choice1.visible = torf
	choice2.visible = torf
	$concedeButton.visible = torf
	
#This will disable a hitbox, since clicking on some things will inspire text prompts,
#so during dialogue, hitboxes will be disabled
func hitBoxAbility(nameOf:Node,disabled:bool):
	nameOf.disabled = disabled
	
func mouseIsInBlankSpace():
	if(!mouseInChoice1 and !mouseInChoice2 and !mouseInConcede):
		return true
	return false
	
func _on_choice_1_mouse_entered():
	mouseInChoice1 = true
	$choice1.icon = choiceBoxHat
	
func _on_choice_1_mouse_exited():
	mouseInChoice1 = false
	$choice1.icon = choiceBox
	
func _on_choice_2_mouse_entered():
	mouseInChoice2 = true
	$choice2.icon = choiceBoxHat
	
func _on_choice_2_mouse_exited():
	mouseInChoice2 = false
	$choice2.icon = choiceBox

func _on_choice_1_pressed():
	choice1Chosen = true
	
func _on_choice_2_pressed():
	choice2Chosen = true
	
func _on_concede_button_mouse_entered():
	mouseInConcede = true
	$concedeButton.icon = choiceBoxHat

func _on_concede_button_mouse_exited():
	mouseInConcede = false
	$concedeButton.icon = choiceBox

func _on_concede_button_pressed():
	concedeChosen = true
