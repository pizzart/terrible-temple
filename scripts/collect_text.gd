extends Node2D

var symbol

func _ready():
	$Sprite.texture = symbol
	$Position.interpolate_property(self, "position", position, position + Vector2(0, -50), 1.0)
	$Transparency.interpolate_property(self, "modulate", Color.white, Color.transparent, 1.0)
	$Position.start()
	$Transparency.start()
