class_name GoalGate
extends Area3D

signal GoalReached

func _OnPlayerBodyEntered(_body: Node3D) -> void:
	GoalReached.emit()

func AssignLookatTarget(targetPos:Vector3) -> void:
	look_at(targetPos)
