extends Node
class_name BallState

signal state_transition_requested(new_state: Ball.State)

var ball: Ball = null
var ball_sprite: Sprite2D = null
var carrier: Player = null
var player_detection_area: Area2D = null
var animation_player: AnimationPlayer

func setup(context_ball: Ball, context_player_detection_area: Area2D, context_carrier: Player, context_animation_player: AnimationPlayer, context_ball_sprite: Sprite2D) -> void:
	ball = context_ball
	ball_sprite = context_ball_sprite
	carrier = context_carrier
	player_detection_area = context_player_detection_area
	animation_player = context_animation_player
