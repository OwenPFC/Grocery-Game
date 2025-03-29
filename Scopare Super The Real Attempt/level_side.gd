extends levelScript

signal flipH
signal canMove(aBool:bool)

var isInCookieArea = false
# Called when the node enters the scene tree for the first time
var timerStarted = false

var choiceBox = load("res://TextBox2.png")
var choiceBoxHat = load("res://TextBox2HatTransparent.png")


"""
-So when an itme is taken we should totally change the graphic so they disappear right?

^ ie, DRAW YOUR INTERACTABLES SEPERATE FROM THE BACKGROUND YOU FUCK

-When he's in an interactable area, a little exclamation mark should appear somewhere, right?
"""




func _ready():
	get_child(0).request_ready()
	
	if Global.color == "pink":
		pass #Methinks this will not work when you try and go back to pink, but WE'LL SEE
		#$textbox.texture = load("res://TextBox2HatTransparent.png")
	else: 
		var pathName = "res://textbox variants/" + Global.color + ".png"
		var pathName2 = "res://textbox variants/" + Global.color +" 2.png"
		choiceBox = load(pathName2)
		choiceBoxHat = load(pathName)
		$cookieMenu.texture = choiceBox
	
	$"grocery guy side".position.x = Global.ggSideLocation 
	
	if($"grocery guy side".position.x <=-500):
		flipH.emit()
	if($"grocery guy side".position.x >=400):
		flipH.emit()
	
	#This is if you enter the level side prior to meatman disappearing,
	#this will do it
	if(levelGetter("negotiation")):
		makeTrue("meatIsGone")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("Interact") or Input.is_action_just_pressed("Interact_Click"):
		#This whole thing is making it so when in cookieArea, you press e and then the options appear
		if isInCookieArea:
			canMove.emit(false)
			$cookieMenu.visible = true
			$Label.visible = true
			$take.visible = true
			$leave.visible = true	
			$Label.text = "Hmmmmmm cookie"
			$take.text = "Take"
			$leave.text = "Walk away"
			
	if($Timer.is_stopped()):
		$actionIndicator.visible = false
	
	if(Input.is_action_just_pressed("Left")):
		$take.grab_focus()
	if(Input.is_action_just_pressed("Right")):
		$leave.grab_focus()
		

func _on_left_exit_body_entered(_body):
	$"grocery guy side".disable = true
	$"grocery guy side".position.x = Global.ggSideLocation
	
	if(Global.globalRote > -1.8 and Global.globalRote < 1.8):
		Global.globalRote = -3.11
		Global.locationX = Global.locationX + 260
	#OK I HAVE TO HARD CODE A VALUE FOR Y BECAUSE OTHERWISE IT GETS FUCKED WHEN YOU COME IN FROM THE RIGHT
		#Global.locationY = Global.locationY - 100
		Global.locationY = 435
	changeToTop()

func _on_right_exit_body_entered(_body):
	$"grocery guy side".disable = true
	
	if(Global.globalRote < -2 or Global.globalRote > 2):
		Global.locationX = Global.locationX - 260

	Global.locationY = 95
	Global.globalRote = 0
	
	changeToTop()
	
func _on_cookie_area_body_entered(_body):
	isInCookieArea = true
	$"grocery guy side/exclamation".visible = true
	
	
func _on_take_pressed():
	canMove.emit(true)
	$cookieMenu.visible = false
	$Label.visible = false
	$take.visible = false
	$leave.visible = false
	makeTrue("hasCookie")
	$actionIndicator.visible = true
	$actionIndicator.text = "*You have taken the cookies*"
	$cookieArea/CollisionShape2D.disabled = true
	isInCookieArea = false
	$Timer.start(5) #For the action indicator
	$"grocery guy side/exclamation".visible = false
	
func _on_leave_pressed():
	canMove.emit(true)
	$cookieMenu.visible = false
	$Label.visible = false
	$take.visible = false
	$leave.visible = false
	
func _on_cookie_area_body_exited(_body):
	$"grocery guy side/exclamation".visible = false
	isInCookieArea = false
	
func _on_take_mouse_entered():
	$take.icon = choiceBoxHat
	
func _on_take_mouse_exited():
	$take.icon = choiceBox

func _on_take_focus_entered():
	$take.icon = choiceBoxHat

func _on_take_focus_exited():
	$take.icon = choiceBox
	
func _on_leave_mouse_entered():
	$leave.icon = choiceBoxHat

func _on_leave_mouse_exited():
	$leave.icon = choiceBox

func _on_leave_focus_entered():
	$leave.icon = choiceBoxHat

func _on_leave_focus_exited():
	$leave.icon = choiceBox
