extends PlayerState
class_name PlayerStateVolleyKick

var air_connect_min_height := 10.0
var air_connect_max_height := 30.0

const BONUS_POWER := 1.8

func _enter_tree() -> void:
	animation_player.play("volley_kick")
	ball_detection_area.body_entered.connect(on_ball_entered.bind())

func on_ball_entered(contact_ball: Ball) -> void:
	print("volley!")
	if contact_ball.can_air_connect(air_connect_min_height, air_connect_max_height):
		print("can air connect volley")
		var destination := target_goal.get_random_target_position()
		var direction := ball.position.direction_to(destination)
		contact_ball.shoot(direction * player.power * BONUS_POWER)


func on_animation_complete() -> void:
	transition_state(Player.State.RECOVERING)
