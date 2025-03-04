extends Node

var _CurrentLevel:Node3D = null
var CurrentLevelData:LevelData = null

var _MainMenuTrack: AudioStream = preload("res://Audio/Music/(Menu) Ryan Yunck - Silent World.mp3")
var _LevelTracks: Array[AudioStream] = [
	preload("res://Audio/Music/(Level) ChillLofi.ogg"),
	preload("res://Audio/Music/(Level) napping_on_a_cloud.ogg"),
	preload("res://Audio/Music/(Level) symphony - 01 clouds.mp3"),
]

func _ready() -> void:
	MenuManager.OpenMenu("Start")
	
	# Play start menu music
	AudioHandler.PlayMusic(_MainMenuTrack)

func StartLevel(levelData:LevelData) -> void:
	# Load in Level
	if levelData: 
		CurrentLevelData = levelData
		_CurrentLevel = levelData.PackedLevel.instantiate()
		add_child(_CurrentLevel)
	
	SignalBus.StartLevel.emit()
	Resume()
	
	# Play a random Level Song
	AudioHandler.PlayMusic(_LevelTracks.pick_random())

func Restart() -> void:
	if CurrentLevelData:
		_ExitGameplay()
		_CurrentLevel = CurrentLevelData.PackedLevel.instantiate()
		add_child(_CurrentLevel)
		SignalBus.StartLevel.emit()
		Resume()
	else:
		ToLevelSelect()

func CompleteLevel() -> void:
	SignalBus.CompleteLevel.emit()
	
	if CurrentLevelData: 
		CurrentLevelData.Completed = true
		ResourceSaver.save(CurrentLevelData)
	
	# Open "You Win" Menu
	_ExitGameplay()
	MenuManager.OpenMenu("Win")

func FailLevel() -> void:
	# Open "You Lose" Menu
	_ExitGameplay()
	MenuManager.OpenMenu("Lose")

func ToLevelSelect() -> void:
	_ExitGameplay()
	CurrentLevelData = null
	MenuManager.OpenMenu("LevelSelect")

func ToStartMenu() -> void:
	_ExitGameplay()
	CurrentLevelData = null
	MenuManager.OpenMenu("Start")
	
	# Play start menu music
	AudioHandler.PlayMusic(_MainMenuTrack)

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
