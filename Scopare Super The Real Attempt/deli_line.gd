extends levelScript

var indicatorVisible = false
signal deliLineIndicators(areVisible:bool)

var clockRan = false

var firstGone = false
var secondGone = false
var thirdGone = false

# Called when the node enters the scene tree for the first time.
func _ready():
	stateOfLine()
	
"""
I feel like maybe I should retool this so that if you leave they don't just dissappear,
but at the moment I think this is just a better way to move forward for the moment
"""


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if levelGetter("negotiation") and !clockRan:
		$Timer.start(25)
		clockRan = true
	if(int($Timer.get_time_left()) == 20):
		makeTrue("first")
	if(int($Timer.get_time_left()) == 10):
		makeTrue("second")
	if(int($Timer.get_time_left()) == 0 and clockRan):
		makeTrue("third")
	
	#moving the whole unit, once is completed, move the whole deli line up until
	#npc1.y < 100, then firstGone = true, and then we do the same for the second
	#and so on
	if(levelGetter("negotiation") and $".".position.y > -80):
		#I think for each iteration we look for the y to be about 30ish less?
		$".".position.y -=100*delta
		Global.deliLineY = $".".position.y
	else:
		Global.deliLineY = $".".position.y
	
	#So basically I just need to update each y position globally every frame within these ifs,
	#no problemo
	if(levelGetter("first") and $"npc2".position.y>300 and !levelGetter("second")):
		$npc2.position.y -=100*delta
		Global.deliLineY2 = $npc2.position.y
		$npc3.position.y-=90*delta
		Global.deliLineY3 = $npc3.position.y
		
	#else:
		#Global.deliLineY2 = $npc2.position.y
		#$npc3.position.y-=90*delta
		#Global.deliLineY3 = $npc3.position.y
	if(levelGetter("second") and $npc3.position.y>300 and !levelGetter("third")):
		$npc3.position.y-=50*delta
		Global.deliLineY2 = $npc2.position.y
		Global.deliLineY3 = $npc3.position.y
	else:
		#same thing as above brother
		Global.deliLineY = $".".position.y
		
	if(levelGetter("first") and !firstGone):
		$npc1/npc1ActionArea.monitoring = false
		#$npc1/hitbox.disabled = true
		if($npc1.position.x > 500):
			$npc1.position.x -= 100*delta
		else:
			$npc1.position.y += 100*delta
		if $npc1.position.y > 800:
			$npc1.position.y = -300
			$npc1.visible = false
			firstGone = true
	if(levelGetter("second") and !secondGone):
		$npc2/npc2ActionArea.monitoring = false
		#$npc2/hitbox.disabled = true
		if($npc2.position.x > 500):
			$npc2.position.x -= 100*delta
		else:
			$npc2.position.y += 100*delta
		if $npc2.position.y > 800:
			$npc2.position.y = -300
			$npc2.visible = false
			secondGone = true
	if(levelGetter("third") and !thirdGone):
		$npc3/npc3ActionArea.monitoring = false
		#$npc3/hitbox.disabled = true
		if($npc3.position.x > 500):
			$npc3.position.x -= 90*delta
		else:
			$npc3.position.y += 90*delta
		if $npc2.position.y > 800:
			$npc3.position.y = -300
			$npc3.visible = false
			thirdGone = true
		
	if(firstGone and secondGone and thirdGone):
		queue_free()

func stateOfLine():
	$".".position.y = Global.deliLineY
	$npc2.position.y = Global.deliLineY2
	$npc3.position.y = Global.deliLineY3
	
	if levelGetter("first"):
		firstGone = true
		$npc1/npc1ActionArea.monitoring = false
		#$npc1/hitbox.disabled = true
		$npc1.visible = false
	if levelGetter("second"):
		secondGone = true
		$npc2/npc2ActionArea.monitoring = false
		#$npc2/hitbox.disabled = true
		$npc2.visible = false
	if levelGetter("third"):
		thirdGone = true
		$npc3/npc3ActionArea.monitoring = false
		#$npc3/hitbox.disabled = true
		$npc3.visible = false

func _on_npc_1_action_area_body_entered(_body):
	if(!visibleIndicator()):
		$npc1/indicator.visible = true
		deliLineIndicators.emit(true)

func _on_npc_1_action_area_body_exited(_body):
	$npc1/indicator.visible = false
	deliLineIndicators.emit(false)

func _on_npc_2_action_area_body_entered(_body):
	if(!visibleIndicator()):
		$npc2/indicator.visible = true
		deliLineIndicators.emit(true)

func _on_npc_2_action_area_body_exited(_body):
	$npc2/indicator.visible = false
	deliLineIndicators.emit(false)

func _on_npc_3_action_area_body_entered(_body):
	if(!visibleIndicator()):
		$npc3/indicator.visible = true
		deliLineIndicators.emit(true)

func _on_npc_3_action_area_body_exited(_body):
	$npc3/indicator.visible = false
	deliLineIndicators.emit(false)
	
func visibleIndicator():
	return $npc1/indicator.visible or $npc2/indicator.visible or $npc3/indicator.visible or indicatorVisible

func _on_deli_scene_indicator_visible(isVisible):
	indicatorVisible = isVisible
