extends Node

var _CurrentLevel:Node3D = null
var CurrentLevelData:LevelData = null

func _ready() -> void:
	MenuManager.OpenMenu("Start")

func StartLevel(levelData:LevelData) -> void:
	# Load in Level
	if levelData: 
		CurrentLevelData = levelData
		_CurrentLevel = levelData.PackedLevel.instantiate()
		add_child(_CurrentLevel)
	
	Resume()
	SignalBus.StartLevel.emit()

func CompleteLevel() -> void:
	if CurrentLevelData: 
		CurrentLevelData.Completed = true
		ResourceSaver.save(CurrentLevelData)
		#CurrentLevelData = null
	
	# Open "You Win" Menu
	_ExitGameplay()
	MenuManager.OpenMenu("Win")

func ToLevelSelect() -> void:
	_ExitGameplay()
	MenuManager.OpenMenu("LevelSelect")

func ToStartMenu() -> void:
	_ExitGameplay()
	MenuManager.OpenMenu("Start")

func Pause() -> void:
	if !StateManager.IsGameplay(): return
	
	get_tree().paused = true
	MenuManager.OpenMenu("Pause")

func Resume() -> void:
	MenuManager.CloseMenus()
	get_tree().paused = false
	StateManager.GameState = StateManager.States.GAMEPLAY


func _ExitGameplay() -> void:
	get_tree().paused = false
	if _CurrentLevel != null && !_CurrentLevel.is_queued_for_deletion(): _CurrentLevel.queue_free()
