extends PanelContainer

@export var _FadeInTime:float = 0.8
var _FadeInTween:Tween = null

func _ready() -> void:
	SignalBus.StartLevel.connect(_LevelStart)

func _LevelStart() -> void:
	if _FadeInTween: _FadeInTween.kill()
	
	modulate = Color.BLACK
	_FadeInTween = create_tween()
	_FadeInTween.tween_property(self, "modulate", Color.TRANSPARENT, _FadeInTime)
