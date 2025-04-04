extends levelScript

"""
Hello there future me. I realize that I organized the tree really terribly, and that meatman and attendant should
each have their own scenes with all of that functionality in there... but I forgot about that.

I will do that for the other scenes, but for now we just have to live with it unfortunately
"""

var numInteractions = 0
var letterIndex = 0
var isTalking = false
signal pauseGGTop(isPaused:bool)
signal indicatorVisible(isVisible:bool)

var clockRan = false
var activeList = []
var talking = ["a","b","c","d","e","f","!"] #this is for completed
var talking2 = ["goopman","poopman","!"] #this is for A, if you talk to him before meatman leaves
var talking3 = ["shoopy","oopy","bajoogie","!"] #this is for A, after meatman leaves
var meatOneOff = ["start","Buzz off dude", ""] #I think this doesn't need to exist anymore
var completed = false
var meatBeat = false

var meatHasLeft = false

signal moveGGALittle

var deliLineVisible = false
# Called when the node enters the scene tree for the first time.
func _ready():
	completed = levelGetter("negotiation")
	meatBeat = levelGetter("meat")
	stateOfMeat()
	
	"""
	if level var that says meatAndASeperate,
	Then monitoring for both action areas are true, disabled
	for both hitboxes are false, both bodies are visible
	
	Also store this state to a local variable I imagine I will need it
	"""

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	"""
	In the code handling how he walks, set his forward facing animation to a var
	holding a string. The meat code above will set that string name based on whether he
	won or lost
	"""
	
	
	
	#This handles how meatman moves post completing his mission
	if(levelGetter("meat")): #this will update stuff regarding beating the meatman
		$meatManBody/meatMan/meatSprite.animation = "sad_walk"
		$meatManBody/meatMan/meatSprite.play("sad_walk")
	else:
		pass
	if(levelGetter("negotiation")):
		$meatManBody/meatMan.monitoring = false
		#$meatManBody/meatHitBox.disabled = true
		if($meatManBody.position.x > 500):
			$meatManBody.position.x -= 2
		else:
			$meatManBody.position.y += 2
		if $meatManBody.position.y > 800:
			$meatManBody.position.y = -300
			$meatManBody.visible = false
			makeTrue("meatIsGone") 
			
			"""
			Need to get walking animations, side view and front view, holding lots of meat if you fail, holding a little meat
			otherwise
			"""

	
	if((Input.is_action_just_pressed("Interact") or Input.is_action_just_pressed("Interact_Click")) and $combined/indicatorCombined.visible):
		isTalking = true
		pauseGGTop.emit(true)
		$combined/indicatorCombined.visible = false
		#I'm not sure why this is here? The meatman one?
		$meatManBody/meatMan/indicatorM.visible = false
		if !levelGetter("runClock"):
			activeList = talking
		elif !levelGetter("negotiation"):
			activeList = talking2
		else:
			activeList = talking3
		$combined/meatAndA.play("fall")
	
	
	#interacting with meatman changes to the negotiation scene
	if((Input.is_action_just_pressed("Interact") or Input.is_action_just_pressed("Interact_Click")) and $meatManBody/meatMan/indicatorM.visible):
		if(levelGetter("clockLevel")):
			changeToMeat()
		#else:
			#isTalking = true
			#$textBox.visible = true
			#activeList = meatOneOff
	
	################################################
	#This is all attendant timer stuff
	if(((Input.is_action_just_pressed("Interact") or Input.is_action_just_pressed("Interact_Click"))and $attendantBody/actionAreaAttendant/indicatorA.visible)):
		isTalking = true
		pauseGGTop.emit(true)
		$attendantBody/actionAreaAttendant/indicatorA.visible = false
		$meatManBody/meatMan/indicatorM.visible = false
		#This tree is saying if the clock hasn't been ran, do the initial dialogue. If it's ran
		#but not completed, do talking2, if both, do 3
		if !levelGetter("clockLevel"):
			activeList = talking
			print("talking")
		elif !levelGetter("negotiation"):
			activeList = talking2
			print("talking2")
		else:
			activeList = talking3
			print("talking3")
		
		$textBox.visible = true
	if(isTalking):
		#dialogue
		if(Input.is_action_just_pressed("Interact") and $textBox.visible):
			numInteractions = numInteractions+1
			$textBox.text = ""
			letterIndex = 0
		if(numInteractions<len(activeList)):
			if(letterIndex<len(activeList[numInteractions])):
				$textBox.text = $textBox.text + activeList[numInteractions][letterIndex]
				letterIndex = letterIndex+1
				
		if($textBox.text == "!"):
			$textBox.visible = false
			pauseGGTop.emit(false)
			isTalking = false
			#This is where the attendant starts crawling
			if !clockRan and !levelGetter("clockLevel"):
				$"attendantBody/actionAreaAttendant/attendant sprites".animation = "crawl"
				$"attendantBody/actionAreaAttendant/attendant sprites".play("crawl")
				$"attendantBody/actionAreaAttendant/attendant sprites".scale.x *= 3
				$"attendantBody/actionAreaAttendant/attendant sprites".scale.y *= 3
				makeTrue("crawling")
			#THIS IS HOW YOU GET TALKING 2 IN THERE LETS GOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
			activeList = talking2
			
			if(!clockRan and !levelGetter("clockLevel")):
				#starts timer, if it hits 0, mission is failed
				makeTrue("clock")
				print("clock is ran")
				#tracks when the clock was used so the == 0 flag doesn't automatically go
				clockRan = true
	#Attendant crawls away after finishing first dialogue
	if $"attendantBody/actionAreaAttendant/attendant sprites".animation == "crawl":
		if $attendantBody.position.x>500:
			$attendantBody.position.x -= 2
		else:
			$"attendantBody/actionAreaAttendant/attendant sprites".animation = "lay"
			#next time meat state is called, he will stand
	#removes clock from screen when time == 0 and also gets rid of the meatman
	if(levelGetter("timedOut") or completed):
		#The make true is if the timedOut is there, this way it still registers
		#as a fail state
		makeTrue("negotiation")
		completed = true

func stateOfMeat():
	if levelGetter("isCombined"):
		$combined/meatAndA.play("pull")
	else:
		$combined.visible = false
		$combined/CollisionShape2D.disabled = true
		$combined/actionAreaCombined.monitoring = false
		
		#$attendantBody.position.x = 650
		$attendantBody.visible = true
		#$attendantBody/CollisionShape2D.disabled = false
		#I think if I always have it enabled but just make it so combined wont detect collisions from
		#attendant should fix my issue with GG getting stuck in attendants body when he first spawns in
		$attendantBody/actionAreaAttendant.monitoring = true
		
		if(levelGetter("crawling")):
			$"attendantBody/actionAreaAttendant/attendant sprites".animation = "stand"
			$attendantBody.position.x = 580
		else:
			$"attendantBody/actionAreaAttendant/attendant sprites".play("pant")
			
		"""
		Once meatman has gone, on the next meatstate, the attendant should return to his
		original position
		"""
		if(!levelGetter("meatIsGone")):
			$meatManBody.visible = true
			$meatManBody/meatHitBox.disabled = false
			$meatManBody/meatMan.monitoring = true
		else:
			$"attendantBody/actionAreaAttendant/attendant sprites".animation = "stand"
			$attendantBody.position.x = 580
			
func hitBoxAbility(nameOf:Node,disabled:bool):
	nameOf.disabled = disabled

func _on_action_area_attendant_body_entered(_body):
	#Checking to see another guy isn't already highlighted
	if(!$meatManBody/meatMan/indicatorM.visible):
		$attendantBody/actionAreaAttendant/indicatorA.visible = true
		indicatorVisible.emit(true)
		numInteractions = 0

func _on_action_area_attendant_body_exited(_body):
	$attendantBody/actionAreaAttendant/indicatorA.visible = false
	numInteractions = 0
	$textBox.visible = false
	indicatorVisible.emit(false)
	isTalking = false
	pauseGGTop.emit(false)

func _on_meat_man_body_entered(_body):
	#checking to see another guy isn't already highlighted
	if(!$attendantBody/actionAreaAttendant/indicatorA.visible):
		$meatManBody/meatMan/indicatorM.visible = true
		indicatorVisible.emit(true)
	numInteractions = 0

func _on_meat_man_body_exited(_body):
	$meatManBody/meatMan/indicatorM.visible = false
	numInteractions = 0
	$textBox.visible = false
	indicatorVisible.emit(false)
	isTalking = false
	pauseGGTop.emit(false)
	
func _on_action_area_combined_body_entered(body):
	if !deliLineVisible and body is CharacterBody2D:
	#if !deliLineVisible and body != $attendantBody: #Making it so collisions with the hidden attendant body don't matter
													#while having A's hitbox still exist so GG doesn't get trapped in it
		$combined/indicatorCombined.visible = true
		numInteractions = 0
		indicatorVisible.emit(true)

func _on_action_area_combined_body_exited(_body):
	$combined/indicatorCombined.visible = false
	numInteractions = 0
	isTalking = false
	pauseGGTop.emit(false)
	indicatorVisible.emit(false)

func _on_meat_and_a_animation_finished():
	if($combined/meatAndA.animation == "fall"):
		makeFalse("isCombined")
		stateOfMeat()
		isTalking = true
		pauseGGTop.emit(false)
		$attendantBody/actionAreaAttendant/indicatorA.visible = false
		$meatManBody/meatMan/indicatorM.visible = false
		activeList = talking
		$textBox.visible = true

func _on_deli_line_deli_line_indicators(areVisible):
	deliLineVisible = areVisible
