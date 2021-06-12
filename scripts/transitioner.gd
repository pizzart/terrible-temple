extends Node

const WAIT: float = 0.3
const TYPE: int = Tween.TRANS_SINE
const EASE_START: int = Tween.EASE_IN
const EASE_END: int = Tween.EASE_OUT

func transition_start():
	$TopTween.interpolate_property($Top, "position", Vector2(0, -110), Vector2(), WAIT, TYPE, EASE_START)
	$BottomTween.interpolate_property($Bottom, "position", Vector2(0, 220), Vector2(0, 110), WAIT, TYPE, EASE_START)
	$TopTween.start()
	$BottomTween.start()
	yield($TopTween, "tween_all_completed")

func transition_end():
	$TopTween.interpolate_property($Top, "position", Vector2(), Vector2(0, -110), WAIT, TYPE, EASE_END)
	$BottomTween.interpolate_property($Bottom, "position", Vector2(0, 110), Vector2(0, 220), WAIT, TYPE, EASE_END)
	$TopTween.start()
	$BottomTween.start()
