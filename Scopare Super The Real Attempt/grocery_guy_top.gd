extends CharacterBody2D

var SPEED = 250.0
var paused = false

var animationName = "ggTop"

func _ready():
	if Global.color == "pink":
		$ggTopAnimated.animation = "ggTop"
		animationName = "ggTop"
	else: 
		$ggTopAnimated.animation = Global.color
		animationName = Global.color
	randomize()

func _physics_process(_delta):
	var rote2 = $".".rotation
	
	if(Input.is_action_just_pressed("Space")):
			print($".".rotation)
		
	if Input.is_action_pressed("Left") and !paused:
		$".".rotation = $".".rotation - 0.01
	if Input.is_action_pressed("Right") and !paused:
		$".".rotation = $".".rotation + 0.01

	if(rote2 < -6.3 or rote2 > 6.3):
			$".".rotation = 0
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var rote = $".".rotation
	
	determineAnimation(rote)

	var direction = Input.get_axis("Up", "Down")
	if !paused:
		if direction:
			#broken wheel
			if(randi_range(0,1000000000) == 20):
				$".".rotation -= 0.4
			rote = $".".rotation
			determineAnimation(rote)
			
			$ggTopAnimated.animation = animationName
			$ggTopAnimated.play(animationName)
			
			if(rote < 0.2 and rote > -0.2):
				#Upwards
				velocity.y = direction * SPEED
				
				#$ggTopAnimated.animation = "ggTop"
				#animationName = "ggTop"
				
			elif(rote < -0.2 and rote > -1.4 or rote > 0.2 and rote < 1.4):
				if(rote>0):
					velocity.x = direction * SPEED*-1
					velocity.y = direction* SPEED
					
					#$ggTopAnimated.animation = "diagonal_back_left_pink"
					#animationName = "diagonal_back_left_pink"
					
				else:
					velocity.x = direction * SPEED
					velocity.y = direction* SPEED
					
					#$ggTopAnimated.animation = "diagonal_back_right_pink"
					#animationName = "diagonal_back_right_pink"
					
			elif(rote < -1.4 and rote > -1.7 or rote > 1.4 and rote < 1.7):
				if(rote > 0):
					velocity.x = direction*SPEED*-1
					
					#$ggTopAnimated.animation = "side_left_pink"
					#animationName = "side_left_pink"
					
				else:
					velocity.x = direction * SPEED
					
					#$ggTopAnimated.animation = "side_right_pink"
					#animationName = "side_right_pink"
					
			elif(rote < -1.7 and rote > -3 or rote > 1.7 and rote < 3):
				if(rote > 0):
					velocity.x = direction * SPEED*-1
					velocity.y = direction* SPEED*-1
					
					#$ggTopAnimated.animation = "diagonal_front_left_pink"
					#animationName = "diagonal_front_left_pink"
					
				else:
					velocity.x = direction * SPEED
					velocity.y = direction* SPEED*-1
					
					#$ggTopAnimated.animation = "diagonal_back_right_pink"
					#animationName = "diagonal_back_right_pink"
					
			elif(rote < -3 and rote > -3.25 or rote > 3 and rote < 3.25):
					velocity.y = direction* SPEED*-1
					
					#$ggTopAnimated.animation = "ggTop_down_pink"
					#animationName = "ggTop_down_pink"
					
			elif(rote < -3.25 and rote > -4.5 or rote > 3.25 and rote < 4.25):
				if(rote > 0):
					velocity.x = direction * SPEED
					velocity.y = direction* SPEED*-1
					
					#$ggTopAnimated.animation = "diagonal_front_right_pink"
					#animationName = "diagonal_front_right_pink"
					
				else:	
					velocity.x = direction * SPEED*-1
					velocity.y = direction* SPEED*-1
					
					#$ggTopAnimated.animation = "diagonal_front_left_pink"
					#animationName = "diagonal_front_left_pink"
					
			elif(rote < -4.25 and rote > -4.8 or rote > 4.25 and rote < 4.8):
				if(rote > 0):
					velocity.x = direction*SPEED
					
					#$ggTopAnimated.animation = "side_right_pink"
					#animationName = "side_right_pink"
					
				else:
					velocity.x = direction*SPEED*-1
					#$ggTopAnimated.animation = "side_left_pink"
					#animationName = "side_left_pink"
					
			elif(rote < -4.8 and rote >-6.15 or rote > 4.8 and rote < 6.15):
				if(rote > 0):
					velocity.x = direction * SPEED*-1
					velocity.y = direction* SPEED
					
					#$ggTopAnimated.animation = "diagonal_back_left_pink"
					#animationName = "diagonal_back_left_pink"
					
				else:	
					velocity.x = direction * SPEED*-1
					velocity.y = direction* SPEED
					
					#$ggTopAnimated.animation = "diagonal_back_left_pink"
					#animationName = "diagonal_back_left_pink"
					
			elif(rote < -6.15 or rote > 6.15):
				velocity.y = direction*SPEED
				
				#$ggTopAnimated.animation = "ggTop"
				#animationName = "ggTop"
				
		else:
			$ggTopAnimated.stop()
			velocity.y = move_toward(velocity.x, 0, SPEED)
			velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		$ggTopAnimated.stop()
		velocity.y = move_toward(velocity.x, 0, SPEED)
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func determineAnimation(rote):
	if(rote < 0.2 and rote > -0.2):
				#Upwards
				$ggTopAnimated.animation = "ggTop_back_" + Global.color
				animationName = "ggTop_back_" + Global.color
				
	elif(rote < -0.2 and rote > -0.5 or rote > 0.2 and rote < 0.5):
				#Back diag
				if(rote>0):
					
					$ggTopAnimated.animation = "diagonal_back_right_" + Global.color
					animationName = "diagonal_back_right_" + Global.color
				else:
					$ggTopAnimated.animation = "diagonal_back_left_" + Global.color
					animationName = "diagonal_back_left_" + Global.color
	elif(rote < -0.5 and rote > -1.2 or rote > 0.7 and rote < 1.2):
				#Almost the sides
				if(rote > 0):	
					#$ggTopAnimated.animation = "side_right_pink"
					#animationName = "side_right_pink"
					$ggTopAnimated.animation = "diagonal_back_right_middle_" + Global.color
					animationName = "diagonal_back_right_middle_" + Global.color
				else:
					$ggTopAnimated.animation = "diagonal_back_left_middle_" + Global.color
					animationName = "diagonal_back_left_middle_" + Global.color
	elif(rote < -1.2 and rote > -2 or rote > 1.2 and rote < 2):
				if(rote>0):
					$ggTopAnimated.animation = "side_right_" + Global.color
					animationName = "side_right_" + Global.color
				else:
					$ggTopAnimated.animation = "side_left_pink" + Global.color
					animationName = "side_left_" + Global.color
					
	elif(rote < -2 and rote > -3 or rote > 2 and rote < 3):
				#front diags
				if(rote > 0):
					$ggTopAnimated.animation = "diagonal_front_right_" + Global.color
					animationName = "diagonal_front_right_" + Global.color
					
				else:
					$ggTopAnimated.animation = "diagonal_front_left_" + Global.color
					animationName = "diagonal_front_left_" + Global.color
					
	elif(rote < -3 and rote > -3.25 or rote > 3 and rote < 3.25):
					#down
					$ggTopAnimated.animation = "ggTop_down_" + Global.color
					animationName = "ggTop_down_" + Global.color
					
	elif(rote < -3.25 and rote > -4.5 or rote > 3.25 and rote < 4.25):
				if(rote > 0):
					$ggTopAnimated.animation = "diagonal_front_left_" + Global.color
					animationName = "diagonal_front_left_" + Global.color
				else:	
					$ggTopAnimated.animation = "diagonal_front_right_" + Global.color
					animationName = "diagonal_front_right_" + Global.color
	elif(rote < -4.25 and rote > -4.8 or rote > 4.25 and rote < 4.8):
				if(rote > 0):
					$ggTopAnimated.animation = "side_left_" + Global.color
					animationName = "side_left_" + Global.color
				else:
					$ggTopAnimated.animation = "side_right_" + Global.color
					animationName = "side_right_" + Global.color
	elif(rote < -4.8 and rote >-6.15 or rote > 4.8 and rote < 6.15):
				if(rote > 0):
					#velocity.x = direction * SPEED*-1
					#velocity.y = direction* SPEED
					
					$ggTopAnimated.animation = "diagonal_back_left_" + Global.color
					animationName = "diagonal_back_left_" + Global.color
					
				else:	
					#velocity.x = direction * SPEED*-1
					#velocity.y = direction* SPEED
					
					$ggTopAnimated.animation = "diagonal_back_left_" + Global.color
					animationName = "diagonal_back_left_" + Global.color
					
	elif(rote < -6.15 or rote > 6.15):
				#velocity.y = direction*SPEED
				
				$ggTopAnimated.animation = "ggTop_back_" + Global.color
				animationName = "ggTop_back_" + Global.color

func _on_quest_man_1_pause_gg_top(isPaused):
	if(isPaused):
		SPEED = 0.0
		paused = true
	else:
		SPEED = 250.0
		paused = false


func _on_deli_scene_pause_gg_top(isPaused):
	if(isPaused):
		SPEED = 0.0
		paused = true
	else:
		SPEED = 250.0
		paused = false


func _on_deli_scene_move_gga_little():
	global_position.y -=1



func _on_freezers_change_to_blue():
	#$ggTopAnimated.animation = "Blue"
	#animationName = "Blue"
	"""Deprecated"""
	pass
	
func _on_freezers_pause_gg_top(isPaused):
	if(isPaused):
		SPEED = 0.0
		paused = true
	else:
		SPEED = 250.0
		paused = false

func _on_free_samples_pause_gg_top(isPaused):
	if(isPaused):
		SPEED = 0.0
		paused = true
	else:
		SPEED = 250.0
		paused = false
