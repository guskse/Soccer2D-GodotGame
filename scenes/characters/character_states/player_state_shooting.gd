extends PlayerState
class_name PlayerStateShooting

func _enter_tree() -> void:
	animation_player.play("kick")

func on_animation_complete() -> void:
	shoot_ball()
	
	#if CPU is shooting, it will go to RECOVERING state, if it's player, will go to MOVE state right away
	if player.control_scheme == Player.ControlScheme.CPU:
		transition_state(Player.State.RECOVERING)
	else:
		transition_state(Player.State.MOVING)


func shoot_ball() -> void:
	ball.shoot(state_data.shot_direction * state_data.shot_power)
