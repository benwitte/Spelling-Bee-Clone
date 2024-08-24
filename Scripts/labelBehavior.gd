extends Label

func _process(_delta):
	sizeChange()

func updateTierText():
	self.text = GlobalVars.newTier

#right now this function isn't actually executed. I'm not sure if it actually
#does anything different than what already happens in the gamescene (possibly
#automatically??)
func sizeChange():
	var fontSize = int(self.size.x/5)
	self.add_theme_font_size_override("font_size", fontSize)
	#while self.theme_override_fonts.font.get_theme_font("font").get_string_size(self.text, HORIZONTAL_ALIGNMENT_LEFT, -1, self.get_theme_font_size("font_size")):
		#fontSize -= 1
		#self.add_theme_font_size_override("font_size", fontSize)
	
	
	#var string_size = $Label.get_theme_font("font").get_string_size($Label.text, HORIZONTAL_ALIGNMENT_LEFT, -1, $Label.get_theme_font_size("font_size"))

#while $Name.font.get_string_size($Name.text, $Name.horizontal_alignment, -1, $Name.font_size).x > $Name.width:
		#$Name.font_size -= 1
