extends HBoxContainer

@onready var submit = $Submit
@onready var shuffle = $Shuffle

@onready var submitLabel = $Submit/Label
@onready var shuffleLabel = $Shuffle/Label


var width : int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if width != self.size.x:
		self.set("theme_override_constants/separation", int(self.size.x/10))
		shuffleLabel.set("theme_override_font_sizes/font_size", int(shuffleLabel.size.y/2))
		submitLabel.set("theme_override_font_sizes/font_size", int(submitLabel.size.x/4))
		width = int(self.size.x)
	pass


func _on_shuffle_pressed():
	GlobalVars.shuffle = true
	print("clicked")
	pass # Replace with function body.


func _on_submit_pressed():
	pass # Replace with function body.


func _on_submit_mouse_entered():
	pass # Replace with function body.


func _on_shuffle_mouse_entered():
	print(get_viewport().gui_get_focus_owner())
	print("entered")
	shuffle.grab_focus()
	pass # Replace with function body.


func _on_shuffle_mouse_exited():
	shuffle.release_focus()
	pass # Replace with function body.
