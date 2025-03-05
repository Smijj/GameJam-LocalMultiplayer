extends CanvasLayer

@export var _TxtYourTime: Label
@export var _TxtNewBestTime: Label

func _ready() -> void:
	SignalBus.OnBestTimeChanged.connect(_OnBestTimeChanged)
	_TxtNewBestTime.visible = false

func _OnBestTimeChanged(time: float, newBest: bool) -> void:
	if _TxtYourTime: 
		_TxtYourTime.text = "Your Time: "+str(time as int)+"s"
	if _TxtNewBestTime:
		if newBest:
			_TxtNewBestTime.visible = true
		else:
			_TxtNewBestTime.visible = false
			
