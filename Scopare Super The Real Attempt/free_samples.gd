extends levelScript

signal pauseGGTop(isPaused:bool)

var isTalking = false
var numInteractions = 0
var letterIndex = 0

var activeList = []
var pinkHatText = ["","YOU","ARE","WEARING","PINK", "!"]
var blueHatText = ["","BYOU","BARE","BWEARING","BLUE", "!"]

var initialText = ["","No repeats","brother", "!"]
var rejectionText = ["","I'VE SEEN YOUR KIND ROUND THESE PARTS", "YOUNG MAN","!"]

var firstTimeTalking = true


"""
Might behoove me to make a dict from string:array, where you're looking for Global.color and 
you're getting the associated color text array
"""
var colorDict = {
	"pink":pinkHatText,
	"Blue":blueHatText
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if((Input.is_action_just_pressed("Interact") or Input.is_action_just_pressed("Interact_Click")) and $sample_indicator.visible):
		isTalking = true
		pauseGGTop.emit(true)
		$sample_indicator.visible = false
		
		if(isFirstTime()):
			activeList = initialText
		else:
			#hat color hasn't been used yet
			if(!levelGetter(Global.color + "Hat")):
				makeTrue(Global.color+"Hat")
				activeList = colorDict.get(Global.color)
			else:
				activeList = rejectionText
		
		$textbox.visible = true
	if(isTalking):
		if(Input.is_action_just_pressed("Interact") and $textbox.visible):
			numInteractions = numInteractions+1
			$textbox.text = ""
			letterIndex = 0
		if(numInteractions<len(activeList)):
			if(letterIndex<len(activeList[numInteractions])):
				$textbox.text = $textbox.text + activeList[numInteractions][letterIndex]
				letterIndex = letterIndex+1
				
		if($textbox.text == "!"):
			$textbox.visible = false
			pauseGGTop.emit(false)
			isTalking = false
			


			
func isFirstTime():
	var temp = !pinkDone and !blueDone and !orangeDone and !joeDone and !awesomeDone and firstTimeTalking and !levelGetter("talkedTo")
	firstTimeTalking = false
	makeTrue("talkedTo")
	return temp

func _on_area_2d_body_entered(body):
	if(body is CharacterBody2D):
		$sample_indicator.visible = true
		isTalking = true
		numInteractions = 0 

func _on_area_2d_body_exited(body):
	$sample_indicator.visible = false
	pauseGGTop.emit(false)
	numInteractions = 0
