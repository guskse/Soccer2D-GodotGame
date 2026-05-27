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
	if player.velocity != Vector2.ZERO:
		#make the cone detection of teammates move in direction player is facing
		teammate_detection_area.rotation = player.velocity.angle()
	
	#PASSING AND SHOOTING INPUT LOGIC
	if player.has_ball():
		if KeyUtils.is_action_just_pressed(player.control_scheme, KeyUtils.Action.PASS):
			transition_state(Player.State.PASSING)
		elif KeyUtils.is_action_just_pressed(player.control_scheme, KeyUtils.Action.SHOOT):
			transition_state(Player.State.PREPPING_SHOT)
	elif ball.can_air_interact():
		if KeyUtils.is_action_just_pressed(player.control_scheme, KeyUtils.Action.SHOOT):
			if player.velocity == Vector2.ZERO:
				#if player is standing and looking towards the opposition's goal, he will volley kick
				if is_facing_target_goal():
					transition_state(Player.State.VOLLEY_KICK)
				else:
					#if player is standing and looking away from the opposition's goal, he will bicycle kick
					transition_state(Player.State.BICYCLE_KICK)
			else:
				#if player is moving and the ball can air interact, he will make a header shot
				transition_state(Player.State.HEADER)


	#TACKLE INPUT LOGIC
	#if !player.has_ball() and player.velocity != Vector2.ZERO and KeyUtils.is_action_just_pressed(player.control_scheme, KeyUtils.Action.SHOOT):
		#transition_state(Player.State.TACKLING)



func is_facing_target_goal() -> bool:
	var direction_to_target_goal := player.position.direction_to(target_goal.position)
	return player.heading.dot(direction_to_target_goal) > 0


#...
