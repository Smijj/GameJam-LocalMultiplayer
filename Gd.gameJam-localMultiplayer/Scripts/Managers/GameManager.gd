extends Node

var _CurrentLevel:Node3D = null
var _CurrentLevelData:LevelData = null

func _ready() -> void:
	MenuManager.OpenMenu("Start")

func StartLevel(levelData:LevelData) -> void:
	# Load in Level
	if levelData: 
		_CurrentLevelData = levelData
		_CurrentLevel = levelData.PackedLevel.instantiate()
		add_child(_CurrentLevel)
	
	Resume()
	SignalBus.StartLevel.emit()

func CompleteLevel() -> void:
	if _CurrentLevelData: 
		_CurrentLevelData.Completed = true
		ResourceSaver.save(_CurrentLevelData)
		_CurrentLevelData = null
		
	ToStartMenu()

func ToStartMenu() -> void:
	get_tree().paused = false
	if _CurrentLevel != null && !_CurrentLevel.is_queued_for_deletion(): _CurrentLevel.queue_free()
	MenuManager.OpenMenu("Start")

func Pause() -> void:
	if !StateManager.IsGameplay(): return
	
	get_tree().paused = true
	MenuManager.OpenMenu("Pause")

func Resume() -> void:
	MenuManager.CloseMenus()
	get_tree().paused = false
	StateManager.GameState = StateManager.States.GAMEPLAY
