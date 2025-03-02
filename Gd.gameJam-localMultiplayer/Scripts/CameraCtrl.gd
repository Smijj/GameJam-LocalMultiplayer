extends Node3D

@export var _Target:Node3D
#@export var _FollowSpeed:float = 1

func _process(delta: float) -> void:
	if !_Target: return
	global_position = _Target.global_position
	global_rotation.y = _Target.global_rotation.y
