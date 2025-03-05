extends Timer

@export var _TimerLabel: Label
var totalTimeTaken:float = 0

func _ready() -> void:
	timeout.connect(_Timeout)
	SignalBus.StartLevel.connect(_LevelStart)
	SignalBus.CompleteLevel.connect(_LevelComplete)
	SignalBus.GoalGateReached.connect(_AddTime)

func _LevelStart() -> void:
	if !GameManager.CurrentLevelData: return
	
	totalTimeTaken = 0
	# Setup timer
	start(GameManager.CurrentLevelData.TimeLimit)

"""
When level is completed, save the amount of time the player took to complete it if its less than their personal best
"""
func _LevelComplete() -> void:
	if GameManager.CurrentLevelData: 
		var newBest: bool = false
		if totalTimeTaken < GameManager.CurrentLevelData.PersonalCompleteTime || GameManager.CurrentLevelData.PersonalCompleteTime < 0:
			GameManager.CurrentLevelData.PersonalCompleteTime = totalTimeTaken
			ResourceSaver.save(GameManager.CurrentLevelData)
			newBest = true
		SignalBus.OnBestTimeChanged.emit(totalTimeTaken, newBest)

func _Timeout() -> void:
	GameManager.FailLevel()

func _process(delta: float) -> void:
	if _TimerLabel:
		_TimerLabel.text = str(time_left as int) + "s"
	
	# track total time 
	totalTimeTaken += delta


func _AddTime(amount:float = 2.5) -> void:
	start(time_left + amount)
