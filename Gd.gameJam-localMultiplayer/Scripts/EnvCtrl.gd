extends WorldEnvironment


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.StartLevel.connect(_LevelStart)

func _LevelStart() -> void:
	if !GameManager.CurrentLevelData || !GameManager.CurrentLevelData.SkyBox: return
	if environment.sky.sky_material is PanoramaSkyMaterial:
		(environment.sky.sky_material as PanoramaSkyMaterial).panorama = GameManager.CurrentLevelData.SkyBox
