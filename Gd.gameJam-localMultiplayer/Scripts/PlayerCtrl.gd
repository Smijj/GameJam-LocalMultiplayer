extends CharacterBody3D

@export var _MoveSpeed:float = 10
@export var _TurnSpeed:float = 35
@export var _DiveDegrees:float = 50
@export var _BankingDegrees:float = 25
@export var _BankingTiltSpeed:float = 2

func _physics_process(delta: float) -> void:
	# Both inputs down - turn up
	if Input.is_action_pressed("p1_rudder_down") && Input.is_action_pressed("p2_rudder_down"):
		rotation.x = move_toward(rotation.x, -deg_to_rad(_DiveDegrees), delta)
		rotation.z = move_toward(rotation.z, 0, delta)
	# Both inputs up - turn down
	elif Input.is_action_pressed("p1_rudder_up") && Input.is_action_pressed("p2_rudder_up"):
		rotation.x = move_toward(rotation.x, deg_to_rad(_DiveDegrees), delta)
		rotation.z = move_toward(rotation.z, 0, delta)
	# p1 Up && p2 Down - turn Hard Left
	elif Input.is_action_pressed("p1_rudder_up") && Input.is_action_pressed("p2_rudder_down"):
		rotate_y(deg_to_rad(_TurnSpeed * 2) * delta) 
		rotation.z = move_toward(rotation.z, deg_to_rad(_BankingDegrees * 2), delta * _BankingTiltSpeed)
		rotation.x = move_toward(rotation.x, 0, delta)
	# p1 Down && p2 Up - turn Hard Right
	elif Input.is_action_pressed("p1_rudder_down") && Input.is_action_pressed("p2_rudder_up"):
		rotate_y(-deg_to_rad(_TurnSpeed * 2) * delta) 
		rotation.z = move_toward(rotation.z, -deg_to_rad(_BankingDegrees * 2), delta * _BankingTiltSpeed)
		rotation.x = move_toward(rotation.x, 0, delta)
	# p1 Up - turn Right
	elif Input.is_action_pressed("p1_rudder_up"):
		rotate_y(deg_to_rad(_TurnSpeed) * delta) 
		rotation.z = move_toward(rotation.z, deg_to_rad(_BankingDegrees), delta * _BankingTiltSpeed)
		rotation.x = move_toward(rotation.x, 0, delta)
	# p1 Down - turn Left
	elif Input.is_action_pressed("p1_rudder_down"):
		rotate_y(-deg_to_rad(_TurnSpeed) * delta) 
		rotation.z = move_toward(rotation.z, -deg_to_rad(_BankingDegrees), delta * _BankingTiltSpeed)
		rotation.x = move_toward(rotation.x, 0, delta)
	# p2 Up - turn Left
	elif Input.is_action_pressed("p2_rudder_up"):
		rotate_y(-deg_to_rad(_TurnSpeed) * delta) 
		rotation.z = move_toward(rotation.z, -deg_to_rad(_BankingDegrees), delta * _BankingTiltSpeed)
		rotation.x = move_toward(rotation.x, 0, delta)
	# p2 Down - turn Right
	elif Input.is_action_pressed("p2_rudder_down"):
		rotate_y(deg_to_rad(_TurnSpeed) * delta) 
		rotation.z = move_toward(rotation.z, deg_to_rad(_BankingDegrees), delta * _BankingTiltSpeed)
		rotation.x = move_toward(rotation.x, 0, delta)
	else:
		rotation.x = move_toward(rotation.x, 0, delta)
		rotation.z = move_toward(rotation.z, 0, delta)
	
	velocity = -transform.basis.z * _MoveSpeed
	move_and_slide()
