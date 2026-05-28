extends Node2D
class_name Goal

@onready var back_net_area: Area2D = $BackNetArea
@onready var targets: Node2D = $Targets

func _ready() -> void:
	back_net_area.body_entered.connect(on_ball_entered_back_net.bind())

func on_ball_entered_back_net(ball: Ball) -> void:
	ball.stop()

func get_random_target_position() -> Vector2:
	var picked_target: Vector2 = targets.get_child(randi_range(0, targets.get_child_count() - 1 )).global_position
	print(picked_target)
	return picked_target

func get_center_target_position() -> Vector2:
	#will return the middle target of goal
	return targets.get_child(int(targets.get_child_count() / 2.0)).global_position
