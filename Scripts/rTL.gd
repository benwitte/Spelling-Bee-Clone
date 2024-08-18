extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	#self.has_theme_font_size_override()
	#add_theme_font_size_override("theme_override_font_sizes/normal_font_size", int(self.size.x))
	#print(self.get_theme_font_size("normal_font_size"))
	pass

func sizeChange():
	var fontSize = int(self.size.x/1.8)
	self.add_theme_font_size_override("normal_font_size", fontSize)
