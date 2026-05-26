extends PlayerState
class_name PlayerStateRecovering

const DURATION_RECOVERY := 500

var time_start_recovery := Time.get_ticks_msec()

func _enter_tree() -> void:
	animation_player.play("recover")
	player.velocity = Vector2.ZERO
	time_start_recovery = Time.get_ticks_msec()


func _process(_delta: float) -> void:
	if Time.get_ticks_msec() - time_start_recovery > DURATION_RECOVERY:
		transition_state(Player.State.MOVING)
