extends CharacterBody3D

@export var _MoveSpeed:float = 10
@export var _TurnSpeed:float = 35
@export var _DiveDegrees:float = 50
@export var _BankingDegrees:float = 25
@export var _BankingTiltSpeed:float = 2

@export_group("Audio")
@export var _PlaneSFX1:AudioStream
@export var _PlaneSFX2:AudioStream
@export var _WindSFX:AudioStream
@export var _ExplosionSFX:AudioStream

var _HitBounds:bool = false

func _ready() -> void:
	SignalBus.StartLevel.connect(_LevelStart)
	StateManager.OnGameStateChanged.connect(_GameStateChanged)

func _GameStateChanged(newState: StateManager.States) -> void:
	if newState != StateManager.States.GAMEPLAY:
		_StopAmbientSFX()
	else:
		_PlayAmbientSFX()

func _LevelStart() -> void:
	var _HitBounds:bool = false
	_PlayAmbientSFX()

func _exit_tree() -> void:
	_StopAmbientSFX()

func _PlayAmbientSFX() -> void:
	AudioHandler.PlayAmbient(_PlaneSFX1)
	AudioHandler.PlayAmbient(_PlaneSFX2)
	AudioHandler.PlayAmbient(_WindSFX)
func _StopAmbientSFX() -> void:
	AudioHandler.StopAmbient(_PlaneSFX1)
	AudioHandler.StopAmbient(_PlaneSFX2)
	AudioHandler.StopAmbient(_WindSFX)


func _physics_process(delta: float) -> void:
	if !_HitBounds:
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			var collider = collision.get_collider()
			if collider.is_in_group("Bounds"):
				_HitBounds = true
				AudioHandler.PlaySFX(_ExplosionSFX, "Explotion")
				GameManager.FailLevel()
				
	
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
