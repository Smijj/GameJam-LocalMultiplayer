extends VBoxContainer

enum Players {
	PLAYER1,
	PLAYER2,
}

@export var _PlayerInput:Players = Players.PLAYER1

@export_category("Refs")
@export var _ControlUp:TextureRect
@export var _ControlDown:TextureRect
@export var _DirIndicator:TextureRect

func _process(delta: float) -> void:
	if _PlayerInput == Players.PLAYER1:
		_HandleUILogic(Input.is_action_pressed("p1_rudder_up"), Input.is_action_pressed("p1_rudder_down"))
	elif _PlayerInput == Players.PLAYER2:
		_HandleUILogic(Input.is_action_pressed("p2_rudder_up"), Input.is_action_pressed("p2_rudder_down"))
	

func _HandleUILogic(inputUp:bool, inputDown:bool) -> void:
	if inputUp:
		# Highlight Input
		if _ControlUp: _ControlUp.modulate = Color.FIREBRICK
		
		# Dir indicator points down 
		if _DirIndicator:
			_DirIndicator.modulate = Color.WHITE
			if !_DirIndicator.flip_v: _DirIndicator.flip_v = true
	else:
		#Unhighlight Input
		if _ControlUp: _ControlUp.modulate = Color.WHITE
		pass

	if inputDown:
		# Highlight Input
		if _ControlDown: _ControlDown.modulate = Color.FIREBRICK
		
		# Dir indicator points up 
		if _DirIndicator:
			_DirIndicator.modulate = Color.WHITE
			if _DirIndicator.flip_v: _DirIndicator.flip_v = false
	else:
		#Unhighlight Input
		if _ControlDown: _ControlDown.modulate = Color.WHITE
	
	if !inputUp && !inputDown:
		# Dir indicator hidden
		if _DirIndicator: _DirIndicator.modulate = Color.TRANSPARENT
