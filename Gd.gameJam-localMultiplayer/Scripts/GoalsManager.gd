extends Path3D

@export var _GoalGatePrefab: PackedScene

var _CurrentGoal: GoalGate
var _NextGoal: GoalGate
@export var _CurrentGoalIndex: int = 0

var _GoalGates:Array[GoalGate] = []

func _ready() -> void:
	_SpawnGoals()
	_CurrentGoalIndex = 0
	_SetActiveGoal(_CurrentGoalIndex)

## Iterate through the points of the curve and spawn goal gates that the 
## player has to fly through in order to complete the level
func _SpawnGoals() -> void:
	if curve.point_count <= 0: return
	
	# Instantiate the goal gates
	for index in curve.point_count:
		var newGoalGate: GoalGate = _GoalGatePrefab.instantiate()
		add_child(newGoalGate)
		newGoalGate.global_position = curve.get_point_position(index)
		newGoalGate.visible = false
		_GoalGates.append(newGoalGate)
	
	# Align the goal gates to look at each other
	if _GoalGates.size() > 1:
		for i in _GoalGates.size():
			if i == 0:
				_GoalGates[i].look_at(_GoalGates[i+1].global_position)
				continue
			_GoalGates[i].look_at(_GoalGates[i-1].global_position)

func _SetActiveGoal(goalIndex:int) -> void:
	if goalIndex < 0 || goalIndex >= _GoalGates.size(): return
	_GoalGates[goalIndex].visible = true
	_GoalGates[goalIndex].GoalReached.connect(_GoalReachedCallback)

func _IncrementGoal() -> void:
	if _CurrentGoalIndex < 0: return

	# Final Goal reached
	if _CurrentGoalIndex >= _GoalGates.size()-1:
		print("Final Goal Reached")
		return
	
	# Disconnect the current goal
	_GoalGates[_CurrentGoalIndex].visible = false
	_GoalGates[_CurrentGoalIndex].GoalReached.disconnect(_GoalReachedCallback)
	_CurrentGoalIndex += 1
	
	# Setup the next goal
	_SetActiveGoal(_CurrentGoalIndex)

func _GoalReachedCallback() -> void:
	# Increment Goal
	_IncrementGoal()
	pass
