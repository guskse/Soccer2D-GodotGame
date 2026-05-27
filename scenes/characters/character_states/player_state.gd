extends Node
class_name PlayerState


signal state_transition_requested(new_state: Player.State, state_data: PlayerStateData)

var ai_behavior: AIBehavior = null
var animation_player : AnimationPlayer = null
var player: Player = null
var state_data: PlayerStateData = PlayerStateData.new()
var ball: Ball = null
var teammate_detection_area: Area2D
var ball_detection_area: Area2D
var own_goal: Goal
var target_goal: Goal


func setup(
	context_player: Player,
	context_state_data: PlayerStateData,
	context_animation_player: AnimationPlayer,
	context_ball: Ball,
	context_teammate_detection_area: Area2D,
	context_ball_detection_area: Area2D,
	context_own_goal: Goal,
	context_target_goal: Goal,
	context_ai_behavior: AIBehavior
	) -> void:
	player = context_player
	ball = context_ball
	animation_player = context_animation_player
	state_data = context_state_data
	teammate_detection_area = context_teammate_detection_area
	ball_detection_area = context_ball_detection_area
	own_goal = context_own_goal
	target_goal = context_target_goal
	ai_behavior = context_ai_behavior


func transition_state(new_state: Player.State, player_state_data: PlayerStateData = PlayerStateData.new()) -> void:
	state_transition_requested.emit(new_state, player_state_data)


func on_animation_complete() -> void:
	pass
