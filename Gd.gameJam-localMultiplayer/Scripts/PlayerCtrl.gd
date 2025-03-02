extends CharacterBody3D

@export var _MoveSpeed:float = 10
@export var _TurnSpeed:float = 35
@export var _DiveDegrees:float = 50
@export var _BankingDegrees:float = 25
@export var _BankingTiltSpeed:float = 2

@export_group("Refs")
@export var _StartPos:Marker3D

func _ready() -> void:
	SignalBus.StartLevel.connect(_LevelStart)

func _LevelStart() -> void:
	if _StartPos:
		global_position = _StartPos.global_position
		global_rotation = _StartPos.global_rotation
	else:
		global_position = Vector3.ZERO
		global_rotation = Vector3.ZERO

func _physics_process(delta: float) -> void:
	# Both inputs down - turn up
	if Input.is_action_pressed("p1_rudder_down") && Input.is_action_pressed("p2_rudder_down"):
		# Adjust Roll
		rotation.z = move_toward(rotation.z, 0, delta)
		# Adjust Pitch
		rotation.x = move_toward(rotation.x, deg_to_rad(_DiveDegrees), delta)
	# Both inputs up - turn down
	elif Input.is_action_pressed("p1_rudder_up") && Input.is_action_pressed("p2_rudder_up"):
		# Adjust Roll
		rotation.z = move_toward(rotation.z, 0, delta)
		# Adjust Pitch
		rotation.x = move_toward(rotation.x, -deg_to_rad(_DiveDegrees), delta)
	# p1 Up && p2 Down - turn Hard Left
	elif Input.is_action_pressed("p1_rudder_up") && Input.is_action_pressed("p2_rudder_down"):
		# Adjust Yaw
		rotate_y(deg_to_rad(_TurnSpeed * 2) * delta) 
		# Adjust Roll
		rotation.z = move_toward(rotation.z, deg_to_rad(_BankingDegrees * 2), delta * _BankingTiltSpeed)
		# Adjust Pitch
		rotation.x = move_toward(rotation.x, 0, delta)
	# p1 Down && p2 Up - turn Hard Right
	elif Input.is_action_pressed("p1_rudder_down") && Input.is_action_pressed("p2_rudder_up"):
		# Adjust Yaw
		rotate_y(-deg_to_rad(_TurnSpeed * 2) * delta) 
		# Adjust Roll
		rotation.z = move_toward(rotation.z, -deg_to_rad(_BankingDegrees * 2), delta * _BankingTiltSpeed)
		# Adjust Pitch
		rotation.x = move_toward(rotation.x, 0, delta)
	# p1 Up - turn Right
	elif Input.is_action_pressed("p1_rudder_up"):
		# Adjust Yaw
		rotate_y(deg_to_rad(_TurnSpeed) * delta) 
		# Adjust Roll
		rotation.z = move_toward(rotation.z, deg_to_rad(_BankingDegrees), delta * _BankingTiltSpeed)
		# Adjust Pitch
		rotation.x = move_toward(rotation.x, 0, delta)
	# p1 Down - turn Left
	elif Input.is_action_pressed("p1_rudder_down"):
		# Adjust Yaw
		rotate_y(-deg_to_rad(_TurnSpeed) * delta) 
		# Adjust Roll
		rotation.z = move_toward(rotation.z, -deg_to_rad(_BankingDegrees), delta * _BankingTiltSpeed)
		# Adjust Pitch
		rotation.x = move_toward(rotation.x, 0, delta)
	# p2 Up - turn Left
	elif Input.is_action_pressed("p2_rudder_up"):
		# Adjust Yaw
		rotate_y(-deg_to_rad(_TurnSpeed) * delta) 
		# Adjust Roll
		rotation.z = move_toward(rotation.z, -deg_to_rad(_BankingDegrees), delta * _BankingTiltSpeed)
		# Adjust Pitch
		rotation.x = move_toward(rotation.x, 0, delta)
	# p2 Down - turn Right
	elif Input.is_action_pressed("p2_rudder_down"):
		# Adjust Yaw
		rotate_y(deg_to_rad(_TurnSpeed) * delta) 
		# Adjust Roll
		rotation.z = move_toward(rotation.z, deg_to_rad(_BankingDegrees), delta * _BankingTiltSpeed)
		# Adjust Pitch
		rotation.x = move_toward(rotation.x, 0, delta)
	else:
		# Adjust Roll
		rotation.z = move_toward(rotation.z, 0, ease(delta, -0.85))
		# Adjust Pitch
		rotation.x = move_toward(rotation.x, 0, ease(delta, -0.85))
	
	# Move forward
	velocity = -transform.basis.z * _MoveSpeed
	move_and_slide()
