extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func sizeChange(parentSize, divideSize):
	var fontSize : int = int(parentSize / divideSize)
	self.add_theme_font_size_override("font_size", fontSize)
