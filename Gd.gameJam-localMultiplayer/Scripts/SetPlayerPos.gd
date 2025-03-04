extends Node3D

@export var _StartPos:Marker3D
@export var _Player:CharacterBody3D

func _ready() -> void:
	SignalBus.StartLevel.connect(_LevelStart)

func _LevelStart() -> void:
	if _StartPos:
		_Player.global_position = _StartPos.global_position
		_Player.global_rotation = _StartPos.rotation
	else:
		_Player.global_position = Vector3.ZERO
		_Player.global_rotation = Vector3.ZERO
