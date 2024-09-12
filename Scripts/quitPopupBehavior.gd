extends TextureRect

@onready var h_box_container : HBoxContainer = $HBoxContainer
@onready var quit_label : Label = $HBoxContainer/quitButton/quitLabel
@onready var dont_quit_label : Label = $HBoxContainer/dontQuitButton/dontQuitLabel
@onready var label = $Label

var barSize : float

# Called when the node enters the scene tree for the first time.
func _ready():
	barSize = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if barSize != self.size.x:
		barSize = self.size.x
		setSeparation()
		label.set("theme_override_font_sizes/font_size", self.size.x/8)
		quit_label.set("theme_override_font_sizes/font_size", self.size.x/10)
		dont_quit_label.set("theme_override_font_sizes/font_size", self.size.x/10)
	if GlobalVars.quitClicked == true:
		self.visible = true
	pass


func setSeparation():
	h_box_container.set("theme_override_constants/separation", h_box_container.size.x/8)


func _on_quit_button_pressed():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()


func _on_dont_quit_button_pressed():
	GlobalVars.quitClicked = false
	self.visible = false
	pass # Replace with function body.
