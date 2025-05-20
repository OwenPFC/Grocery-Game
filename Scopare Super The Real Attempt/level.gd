extends Node2D

class_name levelScript


"""
Lindsey in game: says "go away I do not want to serve you"
if you can find the hidden dog behind somewhere then you can talk to them. Gives gg tylenol

"""

#LOADING IN A TON OF DIFFERENT COLORED TEXTURES YAYYYYYY
#EXCEPT DON'T LOAD ANY GROCERY GUY SPRITES I FORGOT I'M ANNOINTED AND MADE THEM ANIMATIONS
@onready var pinkBox = load("res://TextBox2.png")
@onready var pinkBoxHat = load("res://TextBox2HatTransparent.png")

@onready var blueBox = load("res://textbox variants/Blue 2.png")
@onready var blueBoxHat = load("res://textbox variants/Blue.png")

####################################################################



@onready var top = load("res://level_top.tscn").instantiate()
@onready var side = load("res://level_side.tscn").instantiate()
@onready var meat = load("res://meat_negotiation.tscn").instantiate()

@onready var theLevel = get_tree().root.get_child(1)

#This is what determines what hat color and textbox colors to use
#var color = "pink"

#COOKIE QUEST
var hasCookie = false
var cookieAccepted = false
#COOKIE QUEST

#DELI QUEST
var negotiationDone = false
var beatTheMeatMan = false
var runClock = false
var theClockHasBeenRunInTheLevel = false
var timedOut = false
#var previousTime = "Time left in line: 0:00"
var changedToMeat = false #I have no clue what this one is for
var isCombined = true
var meatIsGone = false
var crawling = false
var firstInLine = false
var secondInLine = false
var thirdInLine = false
var cheekyLittleBooleanToForceThisClockToNotInstantlyKillItself = false
#DELI QUEST

#FREE SAMPLE QUEST
var talkedTo = false
var pinkDone = false
var blueDone = false
var orangeDone = false
var joeDone = false
var awesomeDone = false
#FREE SAMPLE QUEST

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(top)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var minute = floor($timerStuff/timeLeft2.get_time_left()/60)
	var seconds = int($timerStuff/timeLeft2.get_time_left()) - minute*60
	
	if(theLevel.runClock):
		$timerStuff/timeLeft2.start(20)
		$timerStuff/clock2.visible = true
		theLevel.theClockHasBeenRunInTheLevel = true
		theLevel.runClock = false
	if((!theLevel.runClock and $timerStuff/timeLeft2.get_time_left()==0) or theLevel.changedToMeat):
		if(theLevel.changedToMeat):
			$timerStuff/timeLeft2.paused = true
		$timerStuff/clock2.visible = false
	##This is to track when the time changes so we can subract seconds from secondsLeft so that the value
	##can be used in the deli line
	#theLevel.previousTime = $timerStuff/clock2.text
	if(seconds>9):
		$timerStuff/clock2.text = "Time left to save the meat: " + str(minute)+":"+str(seconds)
		theLevel.cheekyLittleBooleanToForceThisClockToNotInstantlyKillItself = true
	else:
		$timerStuff/clock2.text = "Time left to save the meat: " + str(minute)+":0"+str(seconds)
	#if previousTime != $timerStuff/clock2.text:
		#theLevel.secondsLeft -=1
		#theLevel.previousTime = $timerStuff/clock2.text
		
	if $timerStuff/clock2.text == "Time left to save the meat: 0:10":
		$timerStuff/clock2.set("theme_override_colors/font_color", Color(179,0,0));
		
	if $timerStuff/clock2.text == "Time left to save the meat: 0:00" and cheekyLittleBooleanToForceThisClockToNotInstantlyKillItself:
		theLevel.timedOut = true
		theLevel.negotiationDone = true
		$timerStuff/clock2.visible = false
	"""
		theLevel.negotiationDone = true
	elif $timerStuff/clock2.text == "Time left in line: 0:06":
		theLevel.firstInLine = true
	elif $timerStuff/clock2.text == "Time left in line: 0:03":
		theLevel.secondInLine = true
	elif $timerStuff/clock2.text == "Time left in line: 0:00":
		theLevel.thirdInLine = true
	"""
	
func changeToSide():
	#Idk which order is better honestly. Remove then add or add then remove
	#was 0 originally prior to the addition of timer stuff
	theLevel.remove_child.call_deferred(theLevel.get_child(1))
	theLevel.add_child.call_deferred(side)
	
	
func changeToTop():
	#was 0 originally prior to the addition of timer stuff
	theLevel.remove_child.call_deferred(theLevel.get_child(1))
	theLevel.add_child.call_deferred(top)
	
#func changeColor(theColor:String):
		#theLevel.color = theColor

func changeToMeat():
	"""
	KILL THE TIMER HERE WHEN GOING, ALSO MAKE SURE THAT WE'RE KILLING THE RIGHT THINGS
	BUT ALSO KEEP THE TIMER IN THE TREE BECAUSE OTHERWISE IT'LL FUCK UP THE OTHER CHANGETOSCENES
	"""
	theLevel.changedToMeat = true
	theLevel.remove_child.call_deferred(theLevel.get_child(1))
	theLevel.add_child.call_deferred(meat)
	
	
	
func makeTrue(nameOfBool:String):
	if(nameOfBool == "hasCookie"):
		theLevel.hasCookie = true
	elif(nameOfBool == "accepted"):
		theLevel.cookieAccepted = true
	elif(nameOfBool == "meat"):
		theLevel.beatTheMeatMan = true
	elif(nameOfBool == "negotiation"):
		theLevel.negotiationDone = true
	elif(nameOfBool == "clock"):
		theLevel.runClock = true
	elif(nameOfBool == "meatIsGone"):
		theLevel.meatIsGone = true
	elif(nameOfBool == "isCombined"):
		theLevel.isCombined = true
	elif(nameOfBool == "crawling"):
		theLevel.crawling = true
	elif(nameOfBool == "first"):
		theLevel.firstInLine = true
	elif(nameOfBool == "second"):
		theLevel.secondInLine = true
	elif(nameOfBool == "third"):
		theLevel.thirdInLine = true
	elif(nameOfBool == "pinkHat"):
		theLevel.pinkDone = true
	elif(nameOfBool == "blueHat"):
		theLevel.blueDone = true
	elif(nameOfBool == "orangeHat"):
		theLevel.orangeDone = true
	elif(nameOfBool == "joeHat"):
		theLevel.joeDone = true
	elif(nameOfBool == "awesomeHat"):
		theLevel.awesomeDone = true
	elif(nameOfBool == "talkedTo"):
		theLevel.talkedTo = true
		
func makeFalse(nameOfBool:String):
	if(nameOfBool == "isCombined"):
		theLevel.isCombined = false
		
		
func levelGetter(nameOfBool:String):
	if(nameOfBool == "hasCookie"):
		return theLevel.hasCookie
	elif(nameOfBool == "accepted"):
		return theLevel.cookieAccepted
	elif(nameOfBool == "meat"):
		return theLevel.beatTheMeatMan
	elif(nameOfBool == "negotiation"):
		return theLevel.negotiationDone
	elif(nameOfBool == "timedOut"):
		return theLevel.timedOut
	elif(nameOfBool == "isCombined"):
		return theLevel.isCombined
	elif(nameOfBool == "meatIsGone"):
		return theLevel.meatIsGone
	elif(nameOfBool == "crawling"):
		return theLevel.crawling
	elif(nameOfBool == "first"):
		return theLevel.firstInLine
	elif(nameOfBool == "second"):
		return theLevel.secondInLine
	elif(nameOfBool == "third"):
		return theLevel.thirdInLine
	elif(nameOfBool == "runClock"):
		return theLevel.runClock
	elif(nameOfBool == "clockLevel"):
		return theLevel.theClockHasBeenRunInTheLevel
	elif(nameOfBool == "pinkHat"):
		return theLevel.pinkDone
	elif(nameOfBool == "BlueHat"):
		return theLevel.blueDone
	elif(nameOfBool == "OrangeHat"):
		return theLevel.orangeDone
	elif(nameOfBool == "JoeHat"):
		return theLevel.joeDone
	elif(nameOfBool == "AwesomeHat"):
		return theLevel.awesomeDone
	elif(nameOfBool == "talkedTo"):
		return theLevel.talkedTo
	#elif(nameOfBool == "color"):
		#return theLevel.color
		#again not a bool but who cares
		
	#elif(nameOfBool == "secondsLeft"):
		#I know this one is an int not a bool but what do you want me to do /|_0_|\
	#	return theLevel.secondsLeft
	
func _on_child_entered_tree(node):
	node.request_ready()

func _on_time_left_2_timeout():
	$timerStuff/clock2.visible = false
	#theLevel.timedOut = true
	#theLevel.negotiationDone = true
