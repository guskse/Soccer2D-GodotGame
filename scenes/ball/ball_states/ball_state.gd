extends Node
class_name BallState

const GRAVITY := 10.0

signal state_transition_requested(new_state: Ball.State)

var ball: Ball = null
var ball_sprite: Sprite2D = null
var carrier: Player = null
var player_detection_area: Area2D = null
var animation_player: AnimationPlayer
var state_data: BallStateData = null


func setup(context_ball: Ball, context_player_detection_area: Area2D, context_carrier: Player, context_animation_player: AnimationPlayer, context_ball_sprite: Sprite2D, context_ball_state_data: BallStateData) -> void:
	ball = context_ball
	ball_sprite = context_ball_sprite
	carrier = context_carrier
	player_detection_area = context_player_detection_area
	animation_player = context_animation_player
	state_data = context_ball_state_data


func transition_state(new_state: Ball.State, data: BallStateData = BallStateData.new()) -> void:
	state_transition_requested.emit(new_state, data)


func set_ball_animation_from_velocity() -> void:
	if ball.velocity == Vector2.ZERO:
		animation_player.play("idle")
	else:
		animation_player.play("roll")


func process_gravity(delta:float, bounciness: float = 0.0) -> void:
	if ball.height > 0 or ball.height_velocity > 0:
		ball.height_velocity -= GRAVITY * delta
		ball.height += ball.height_velocity
		if ball.height < 0:
			ball.height = 0
			if bounciness > 0 and ball.height_velocity < 0:
				ball.height_velocity = -ball.height_velocity * bounciness
				ball.velocity *= ball.bounciness


func move_and_bounce(delta: float) -> void:
	var collision := ball.move_and_collide(ball.velocity * delta)
	if collision != null:
		ball.velocity = ball.velocity.bounce(collision.get_normal()) * ball.bounciness
		ball.switch_state(Ball.State.FREEFORM)


func can_air_interact() -> bool:
	return false


#...
