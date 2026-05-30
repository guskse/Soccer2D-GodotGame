extends BallState
class_name BallStateShot

const DURATION_SHOT := 1000
const SHOT_SPRITE_SCALE := 0.8
const SHOT_HEIGHT := 5

var time_since_shot := Time.get_ticks_msec()

func _enter_tree() -> void:
	set_ball_animation_from_velocity()
	animation_player.play("roll")
	ball_sprite.scale.y = SHOT_SPRITE_SCALE
	ball.height = SHOT_HEIGHT
	time_since_shot = Time.get_ticks_msec()


func _process(delta: float) -> void:
	if Time.get_ticks_msec() - time_since_shot > DURATION_SHOT:
		#if SHOT duration is over, ball will go back to FREEFORM state
		transition_state(Ball.State.FREEFORM)
	else:
		move_and_bounce(delta)


func _exit_tree() -> void:
	#reset the scale of the ball after exiting the state
	ball_sprite.scale.y = 1.0


#...
