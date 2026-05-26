class_name PlayerStateFactory

var states : Dictionary

func _init() -> void:
	states = {
		Player.State.MOVING: PlayerStateMoving,
		Player.State.PASSING: PlayerStatePassing,
		Player.State.TACKLING: PlayerStateTackling,
		Player.State.RECOVERING: PlayerStateRecovering,
		Player.State.PREPPING_SHOT: PlayerStatePreppingShot,
		Player.State.SHOOTING: PlayerStateShooting,
		Player.State.BICYCLE_KICK: PlayerStateBicycleKick,
		Player.State.VOLLEY_KICK: PlayerStateVolleyKick,
		Player.State.HEADER: PlayerStateHeader
	}

func get_fresh_state(state: Player.State) -> PlayerState:
	# make sure state provided exists in the states dictionary
	assert(states.has(state), "state doesn't exist!")
	return states.get(state).new()
