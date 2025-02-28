class_name GoalGate
extends Area3D

signal GoalReached
var _LookatTarget:Node3D

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func _OnPlayerBodyEntered(body: Node3D) -> void:
	GoalReached.emit()


func AssignLookatTarget(targetPos:Vector3) -> void:
	look_at(targetPos)
