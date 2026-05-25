extends Node
class_name PlayerState


signal state_transition_requested(new_state: Player.State, state_data: PlayerStateData)


var animation_player : AnimationPlayer = null
var player: Player = null
var state_data: PlayerStateData = PlayerStateData.new()
var ball: Ball = null


func setup(context_player: Player, context_state_data: PlayerStateData, context_animation_player: AnimationPlayer, context_ball) -> void:
	player = context_player
	ball = context_ball
	animation_player = context_animation_player
	state_data = context_state_data


func transition_state(new_state: Player.State, player_state_data: PlayerStateData = PlayerStateData.new()) -> void:
	state_transition_requested.emit(new_state, player_state_data)


func on_animation_complete() -> void:
	pass
