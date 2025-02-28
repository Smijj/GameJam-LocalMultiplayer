extends Node


func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action("ResetGame"):
		StartGame()

func StartGame() -> void:
	SignalBus.StartGame.emit()

func EndGame() -> void:
	pass
