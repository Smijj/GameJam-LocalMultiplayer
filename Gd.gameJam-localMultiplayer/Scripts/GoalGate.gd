class_name GoalGate
extends Area3D

signal GoalReached

func _OnAreaEntered(_area: Area3D) -> void:
	if !visible: return
	GoalReached.emit()
	SignalBus.GoalGateReached.emit()

func AssignLookatTarget(targetPos:Vector3) -> void:
	look_at(targetPos)
