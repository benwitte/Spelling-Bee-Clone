extends Label



func updateTierText():
	self.text = GlobalVars.newTier

#right now this function isn't actually executed. I'm not sure if it actually
#does anything different than what already happens in the gamescene (possibly
#automatically??)
func sizeChange():
	var fontSize = int(self.size.x/4)
	self.add_theme_font_size_override("font_size", fontSize)
