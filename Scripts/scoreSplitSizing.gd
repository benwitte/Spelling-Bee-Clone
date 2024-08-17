extends HSplitContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	self.split_offset =  self.size.x/-3
	#self.add_theme_constant_override("Separation", 900)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
