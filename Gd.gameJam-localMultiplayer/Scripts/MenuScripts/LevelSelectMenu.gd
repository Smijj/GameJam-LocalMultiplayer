extends CanvasLayer

@export var _LevelSelectButtonsContainer: GridContainer
@export var _LevelScenesResource: LevelScenes

var _Buttons:Array[Button] = []

func _ready() -> void:
	_SetupLevelSelectButtons()
	visibility_changed.connect(_ReloadButtons)
	
func _SetupLevelSelectButtons() -> void:
	if !_LevelSelectButtonsContainer || _LevelScenesResource.Levels.is_empty(): return
	for index in _LevelScenesResource.Levels.size():
		_SetupButton(index, _LevelScenesResource.Levels[index])
		
func _SetupButton(index:int, levelData:LevelData) -> void:
	var newButton = Button.new()
	_LevelSelectButtonsContainer.add_child(newButton)
	
	newButton.text = "Level " + str(index + 1)
	newButton.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	newButton.pressed.connect(func(): GameManager.StartLevel(levelData))
	_Buttons.append(newButton)

func _ReloadButtons() -> void:
	if visible == false || _Buttons.is_empty(): return
	
	for index in _Buttons.size():
		
		if index > 0:
			if _LevelScenesResource.Levels[index-1].Completed:
				_Buttons[index].disabled = false
				# if the previous level has been completed, focus this button instead
				_Buttons[index].grab_focus()
			else:
				# if the previous level hasnt been compeleted, this level is locked
				_Buttons[index].disabled = true
		else:
			# If its the first button in the list select it
			_Buttons[index].grab_focus()
