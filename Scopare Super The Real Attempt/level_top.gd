extends levelScript

# Called when the node enters the scene tree for the first time.
func _ready():
	$ggTop.position.x = Global.locationX
	$ggTop.position.y = Global.locationY
	$ggTop.rotation = Global.globalRote

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_bottom_1_body_entered(_body):
	#$ggTop.rotation = 0
	
	Global.ggSideLocation = -500
	Global.globalRote = $ggTop.rotation
	Global.locationX = $ggTop.position.x
	Global.locationY = $ggTop.position.y + 20

	theLevel.changeToSide()
	
func _on_top_1_body_entered(_body):
	Global.ggSideLocation = 400
	theLevel.changeToSide()


