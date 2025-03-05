extends CanvasLayer

@export var _TxtBestTime: Label
@export var _TxtNewBestTime: Label

func _ready() -> void:
	SignalBus.CompleteLevel.connect(_LevelComplete)

func _LevelComplete() -> void:
	if !GameManager.CurrentLevelData: return
	if _TxtBestTime: _TxtBestTime.text = "Best Time: "+str(GameManager.CurrentLevelData.PersonalCompleteTime as int)+"s"
