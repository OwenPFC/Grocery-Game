extends Node2D


var numSuccessfulHits = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#$jump_slider.connect("poop", _on_jump_slider_poop)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$jump_animation.frame = numSuccessfulHits
	
func increment_hits():
	#print(numSuccessfulHits)
	pass

func _on_jump_slider_1_activate_slide_4():
	$jump_slider_4.global_position.y = 45
	$jump_slider_5.global_position.y = 45
	$jump_slider_6.global_position.y = 45
	$jump_slider_7.global_position.y = 45
	
func _on_jump_slider_4_activate_slider_7():
	$jump_slider_7.global_position.x = 500
	
func _on_jump_slider_1_activate_slide_8():
	$jump_slider_8.global_position.y = 200
	$jump_slider_9.global_position.y = 400

func _on_jump_slider_9_return_to_slide_8():
	$jump_slider_10.global_position.y = 400

func _on_jump_slider_10_activate_slide_11():
	$jump_slider_11.global_position.y = 600

func _on_jump_slider_1_increment():
	numSuccessfulHits+=1
	#print(numSuccessfulHits)


func _on_jump_slider_2_increment():
	numSuccessfulHits+=1
	#print(numSuccessfulHits)


func _on_jump_slider_3_increment():
	numSuccessfulHits+=1
	#print(numSuccessfulHits)


func _on_jump_slider_4_increment():
	numSuccessfulHits+=1
	#print(numSuccessfulHits)


func _on_jump_slider_5_increment():
	numSuccessfulHits+=1
	#print(numSuccessfulHits)


func _on_jump_slider_6_increment():
	numSuccessfulHits+=1
	#print(numSuccessfulHits)


func _on_jump_slider_7_increment():
	numSuccessfulHits+=1
	#print(numSuccessfulHits)


func _on_jump_slider_8_increment():
	numSuccessfulHits+=1
	#print(numSuccessfulHits)

func _on_jump_slider_9_increment():
	numSuccessfulHits+=1
	#print(numSuccessfulHits)

func _on_jump_slider_10_increment():
	numSuccessfulHits+=1
	#print(numSuccessfulHits)


func _on_jump_slider_11_increment():
	numSuccessfulHits+=1
	#print(numSuccessfulHits)
