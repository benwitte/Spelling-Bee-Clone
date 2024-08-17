extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	



func updateProgress():
	var tween := get_tree().create_tween()
	tween.tween_property(self, "value", 100, .7).set_trans(Tween.TRANS_QUAD)
	
func fastUpdate():
	var tween := get_tree().create_tween()
	tween.tween_property(self, "value", 100, .2).set_trans(Tween.TRANS_QUAD)

func updateScore():
	$rTL.text  =str(GlobalVars.score)
	
func clearScore():
	$rTL.text = ""
