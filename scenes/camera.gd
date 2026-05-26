extends Camera2D
class_name Camera

@export var ball: Ball

const DISTANCE_TARGET:= 100.0
const SMOOTHING_BALL_CARRIED := 2
const SMOOTHING_BALL_DEFAULT := 8

func _process(_delta: float) -> void:
	# camera will follow the player position, if he's carrying the ball
	if ball.carrier != null:
		position = ball.carrier.position + ball.carrier.heading * DISTANCE_TARGET
		#change the speed in which the camera will move, if player is carrying a ball it will be smooth_speed = 2
		position_smoothing_speed = SMOOTHING_BALL_CARRIED
	else:
	# if no one is carrying the ball, the camera will go to the ball's position
		position = ball.position
		#change the speed in which the camera will move, if ball is free it will be smooth_speed = 8
		position_smoothing_speed = SMOOTHING_BALL_DEFAULT
