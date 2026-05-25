extends PlayerState
class_name PlayerStatePreppingShot

const DURATION_MAX_BONUS := 1000 #1 second
const EASE_REWARD_FACTOR := 2.0

var shot_direction := Vector2.ZERO
var time_start_shot := Time.get_ticks_msec()

func _enter_tree() -> void:
	animation_player.play("prep_kick")
	player.velocity = Vector2.ZERO
	time_start_shot = Time.get_ticks_msec()


func _process(delta: float) -> void:
	#get shot direction through player input (see key_utils.gd)
	shot_direction += KeyUtils.get_input_vector(player.control_scheme) * delta
	
	if KeyUtils.is_action_just_released(player.control_scheme, KeyUtils.Action.SHOOT):
		#min duration 0.0 and max duration will be 1.0 second, more than that will not add bonus to the shot
		var duration_press := clampf(Time.get_ticks_msec() - time_start_shot, 0.0, DURATION_MAX_BONUS)
		
		var ease_time := duration_press / DURATION_MAX_BONUS
		var bonus := ease(ease_time, EASE_REWARD_FACTOR)
		
		var shot_power := player.power * (1 + bonus)
		shot_direction = shot_direction.normalized() #will transform vector into length 1 (normalize)
		
		var shot_data = PlayerStateData.build().set_shot_direction(shot_direction).set_shot_power(shot_power)
		
		transition_state(Player.State.SHOOTING, shot_data)


#...
