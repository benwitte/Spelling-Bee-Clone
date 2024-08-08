extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	#progressBar($TextureProgressBar1)
	for child in get_children():
		GlobalVars.arrayBars.append(child)
	GlobalVars.arrayBars.pop_front()
	pass # Replace with function body.



func progressBar(childnode):
	childnode.updateProgress()

