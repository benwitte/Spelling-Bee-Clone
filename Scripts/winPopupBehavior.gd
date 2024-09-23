extends TextureRect

@onready var label = $Label
@onready var new_game_button = $HBoxContainer/newGameButton
@onready var new_game_label = $HBoxContainer/newGameButton/newGameLabel
@onready var keep_playing_button = $HBoxContainer/keepPlayingButton
@onready var keep_playing_label = $HBoxContainer/keepPlayingButton/keepPlayingLabel
@onready var h_box_container = $HBoxContainer

var barSize : float

var winText : String = "You Reached Genius!
New Game?"

var settingsText : String = "Start New Game?"
# Called when the node enters the scene tree for the first time.
func _ready():
	barSize = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if barSize != self.size.x:
		barSize = self.size.x
		setSeparation()
		label.set("theme_override_font_sizes/font_size", self.size.x/15)
		new_game_label.set("theme_override_font_sizes/font_size", self.size.x/18)
		keep_playing_label.set("theme_override_font_sizes/font_size", self.size.x/18)
	if GlobalVars.newTier == "Genius":
		await get_tree().create_timer(.4).timeout
		label.text = winText
		self.visible = true
	if GlobalVars.settingsCheck == true:
		label.text = settingsText
		self.visible = true
	pass

func setSeparation():
	h_box_container.set("theme_override_constants/separation", h_box_container.size.x/8)

func _on_keep_playing_button_pressed():
	GlobalVars.settingsCheck = false
	self.visible = false



func _on_new_game_button_pressed():
	GlobalVars.settingsCheck = false
	self.visible = false
	GlobalVars.newGame = true
	
