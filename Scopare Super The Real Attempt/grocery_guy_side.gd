extends CharacterBody2D

const SPEED = 300.0

var disable = false
var canMove = true

var animationName = "ggSide"

func _ready():
	if Global.color == "pink":
		$GgsAnimated.animation = "ggSide"
		animationName = "ggSide"
	else: 
		$GgsAnimated.animation = Global.color
		animationName = Global.color

func _physics_process(_delta):
	$GgsAnimated.animation = animationName
	#This is the movement
	if(Input.is_action_pressed("Right")):
		#velocity.x = 7000*delta
		if canMove:
			$GgsAnimated.flip_h = true
		$hitBoxLeft.disabled = true
		$hitBoxRight.disabled = false
		
	if(Input.is_action_pressed("Left")):
		#velocity.x = -7000*delta
		if canMove:
			$GgsAnimated.flip_h = false
		$hitBoxLeft.disabled = false
		$hitBoxRight.disabled = true
	if(disable):
		$hitBoxLeft.disabled = true
		$hitBoxRight.disabled = true
		disable = false
	else:
		$hitBoxLeft.disabled = false
		$hitBoxRight.disabled = false
		disable = false
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	
	if direction:
		if canMove:
			$GgsAnimated.play(animationName)
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 7000)
		$GgsAnimated.stop()
		
	if !canMove:
		velocity.x=0

	move_and_slide()
	
func _on_level_side_flip_h():
	if($GgsAnimated.flip_h == false):
		$GgsAnimated.flip_h = true
	else:
		$GgsAnimated.flip_h = false

func _on_level_side_can_move(aBool):
	canMove = aBool
