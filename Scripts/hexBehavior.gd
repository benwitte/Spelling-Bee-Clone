extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#_on_pressed()
	pass


func _on_pressed():
	print("pressed")
	pass # Replace with function body.


func _on_button_down():
	print("down")
	pass # Replace with function body.
	
func setLetter(letter):
	self.get_child(0).text = letter
