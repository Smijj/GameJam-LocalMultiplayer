extends Timer

@export var _TimerLabel: Label

func _ready() -> void:
	timeout.connect(_Timeout)
	SignalBus.StartLevel.connect(_LevelStart)

func _LevelStart() -> void:
	if !GameManager.CurrentLevelData: return
	
	# Setup timer
	start(GameManager.CurrentLevelData.TimeLimit)

func _Timeout() -> void:
	GameManager.FailLevel()

func _process(delta: float) -> void:
	if _TimerLabel:
		_TimerLabel.text = str(time_left as int) + "s"
