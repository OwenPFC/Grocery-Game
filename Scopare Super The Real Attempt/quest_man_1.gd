extends levelScript

var numInteractions = 0
var letterIndex = 0
var isSpokenTo = false #This says whether or not player is in interact range
var accepted = false
var cookieGot = false
var numTimesTalked = 0 #This is different to interactions, this is to handle the animation

signal pauseGGTop(isPaused:bool)

# Called when the node enters the scene tree for the first time.
func _ready():
	cookieGot = levelGetter("hasCookie")
	accepted = levelGetter("accepted")


"""
YO I SHOULD TOTALLY CONDENSE THIS INTO AN ARRAY DOLOMITE JOE STYLE
WHEN I GET THE CHANCE, BECAUSE LONG TERM HOLY HELL THIS IS GONNA SUCK

AND DO THE WHOLE LETTER THING
"""
var talking = ["start","Hey bro\n\n(press e)", "I've got a mission for you brother", "This is really important broseph", "...",
"I ain't kidding around bronald mcdonald this is vital stuff here", "Go get me some cookies amigo", "!"]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):	
	#Clicking e when indicator is visible
	if((Input.is_action_just_pressed("Interact") or Input.is_action_just_pressed("Interact_Click")) and $indicator.visible):
		$indicator.visible = false
		$Label.visible = true
		isSpokenTo = true
		numTimesTalked = 0
		numInteractions = 0
		
	
	if((Input.is_action_just_pressed("Interact") or Input.is_action_just_pressed("Interact_Click"))and isSpokenTo and !$cookieManTalk.is_playing()):
			numInteractions = numInteractions+1
			$Label.text = ""
			letterIndex = 0
	if(!accepted and isSpokenTo):
		pauseGGTop.emit(true)
		
		$cookieManTalk.visible = true
		if(numInteractions<len(talking)):
			if(letterIndex<len(talking[numInteractions])):
				$Label.text = $Label.text + talking[numInteractions][letterIndex]
				letterIndex = letterIndex+1
	
		#print(numInteractions)
		if(numInteractions == 1):
			#$Label.text = "Hey bro"
			if(numTimesTalked == 0):
				$cookieManTalk.play("heyBroReal",1.4)
			if($cookieManTalk.frame == 5):
				$cookieManTalk.stop()
				numTimesTalked = 1
			
		elif(numInteractions == 2):
			if(numTimesTalked == 1):
				$cookieManTalk.play("gotAMissionReal",1.6)
			if($cookieManTalk.frame == 19):
				$cookieManTalk.stop()
				numTimesTalked = 2
				$cookieManTalk.frame = 19
	
		elif(numInteractions == 3):
			if(numTimesTalked == 2):
				$cookieManTalk.play("broseph",1.6)
			if($cookieManTalk.frame == 14):
				$cookieManTalk.stop()
				numTimesTalked=3
				$cookieManTalk.frame = 14
				
		elif(numInteractions == 4):
			if(numTimesTalked == 3):
				$cookieManTalk.play("swallow",1.4)
			if($cookieManTalk.frame == 26):
				$cookieManTalk.stop()
				numTimesTalked = 4
				$cookieManTalk.frame = 26
		
		elif(numInteractions == 5):
			if(numTimesTalked == 4):
				$cookieManTalk.play("bronald",1.4)
			if($cookieManTalk.frame == 27):
				$cookieManTalk.stop()
				numTimesTalked = 5
				$cookieManTalk.frame = 27
		
		elif(numInteractions == 6):
			if(numTimesTalked == 5):
				$cookieManTalk.play("amigo",1.4)
			if($cookieManTalk.frame == 19):
				$cookieManTalk.stop()
				numTimesTalked = 6
				$cookieManTalk.frame = 19
			
		if(numInteractions == 7):
			#$Label.text = "!!!!"
			makeTrue("accepted")
			accepted = true #I only do this because it makes the program flow easier
			#There's no reason to call the function to get the level's value if I can just make this true
			#and then send it to the next if
			pauseGGTop.emit(false)
	if($Label.text == "!"):
		$Label.visible = false
		$cookieManTalk.visible = false
		numInteractions = 0
		
	if(accepted and numInteractions > 0 and !Global.cookieQuestComplete):
		if(!cookieGot):
			$Label.text = "Come on bro I need this"
		else:
			pauseGGTop.emit(true)
			numTimesTalked = 0
			$Label.text = "Thanks bro"
			$cookieManTalk.visible = true
			if(numTimesTalked == 0):
				$cookieManTalk.play("smile",1.2)
				numTimesTalked = 1
			if($cookieManTalk.frame ==30):
				$cookieManTalk.stop()
				$cookieManTalk.frame = 30
			if(numInteractions == 2):
				$Label.text = "!"
				pauseGGTop.emit(false)
				$cookieManTalk.visible = false
				$Label.visible = false
				
			
				Global.cookieQuestComplete = true

func _on_area_2d_body_entered(_body):
	$indicator.visible = true
	
func _on_area_2d_body_exited(_body):
	$indicator.visible = false
	
	$Label.visible = false
	numInteractions = 0
	isSpokenTo = false

