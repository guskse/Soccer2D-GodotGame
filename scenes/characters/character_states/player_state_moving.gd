extends PlayerState
class_name PlayerStateMoving

func _process(_delta) -> void:
	if player.control_scheme == Player.ControlScheme.CPU:
		pass # Process AI Movement
	else:
		handle_human_movement()
	
	player.set_movement_animation()
	player.set_heading()

func handle_human_movement():
	var direction := KeyUtils.get_input_vector(player.control_scheme)
	player.velocity = direction * player.speed
	
	#PREP SHOOT LOGIC
	if player.has_ball() and KeyUtils.is_action_just_pressed(player.control_scheme, KeyUtils.Action.SHOOT):
		state_transition_requested.emit(Player.State.PREPPING_SHOT)
	
	#TACKLE INPUT LOGIC
	if player.velocity != Vector2.ZERO and KeyUtils.is_action_just_pressed(player.control_scheme, KeyUtils.Action.SHOOT):
		state_transition_requested.emit(Player.State.TACKLING)
