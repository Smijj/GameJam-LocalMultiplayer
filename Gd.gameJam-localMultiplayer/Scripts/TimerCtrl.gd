extends Timer

@export var _TimerLabel: Label

func _ready() -> void:
	timeout.connect(_Timeout)
	SignalBus.StartLevel.connect(_LevelStart)
	SignalBus.CompleteLevel.connect(_LevelStart)

func _LevelStart() -> void:
	if !GameManager.CurrentLevelData: return
	
	# Setup timer
	start(GameManager.CurrentLevelData.TimeLimit)

func _LevelComplete() -> void:
	if GameManager.CurrentLevelData: 
		var currentTime:float = GameManager.CurrentLevelData.TimeLimit - time_left
		if currentTime < GameManager.CurrentLevelData.PersonalCompleteTime || GameManager.CurrentLevelData.PersonalCompleteTime < 0:
			GameManager.CurrentLevelData.PersonalCompleteTime = currentTime
			ResourceSaver.save(GameManager.CurrentLevelData)

func _Timeout() -> void:
	GameManager.FailLevel()

func _process(delta: float) -> void:
	if _TimerLabel:
		_TimerLabel.text = str(time_left as int) + "s"
