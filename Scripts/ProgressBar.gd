extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	#clear for next usage
	GlobalVars.arrayBars = []
	#progressBar($TextureProgressBar1)
	for child in get_children():
		GlobalVars.arrayBars.append(child.get_child(0))
	#GlobalVars.arrayBars.pop_front()
	pass # Replace with function body.



func progressBar(childnode):
	childnode.updateProgress()
	
func updateNewScore(childnode):
	childnode.updateScore()
	
func clearOldScore(childnode):
	childnode.clearScore()
	
func quickUpdate(childnode):
	childnode.fastUpdate()
