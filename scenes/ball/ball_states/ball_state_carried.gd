extends BallState
class_name BallStateCarried

#ball will be positioned in front and slightly below player
const OFFSET_FROM_PLAYER := Vector2(10.0,2.0)

#will be used to calculate the ball movement when dribbling
const DRIBBLE_FREQUENCY :float = 10.0
const DRIBBLE_INTENSITY :float = 3.0

var dribble_time := 0.0

func _enter_tree() -> void:
	#MAKE SURE CARRIER EXISTS IF NOT, WILL GENERATE ERROR
	assert(carrier != null)

func _process(delta: float) -> void:
	flip_ball_sprite()
	
	var variation_x := 0.0
	dribble_time += delta
	
	#DRIBBLING MOTION DEPENDING ON CARRIER'S MOVEMENT
	if carrier.velocity != Vector2.ZERO:
		if carrier.velocity.x != 0:
			variation_x = cos(dribble_time * DRIBBLE_FREQUENCY) * DRIBBLE_INTENSITY

	#PLAY BALL ANIMATION DEPENDING ON CARRIER'S VELOCITY
	if carrier.velocity != Vector2.ZERO:
		animation_player.play("roll")
	else:
		animation_player.play("idle")
	
	#SET BALL POSITION TO BE IN FRONT AND A LITTLE BELOW THE CARRIER
	ball.position = carrier.position + Vector2(
		variation_x + carrier.heading.x * OFFSET_FROM_PLAYER.x, OFFSET_FROM_PLAYER.y
	)


func flip_ball_sprite() -> void:
	#FLIP BALL SPRITE DEPENDING ON CARRIER'S HEADING DIRECTION
	if carrier.heading == Vector2.LEFT:
		ball.ball_sprite.flip_h = true
	elif carrier.heading == Vector2.RIGHT:
		ball.ball_sprite.flip_h = false
