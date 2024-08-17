extends Node


var arrayBars : = []

var fullDictPath := "res://Data/fullDictionary.json"

var fullParsedFile := []

var allPangramsDict := []

var pangramMain := {}

var totalPangrams := []

var todaysDictionary := []

var todaysWordsArray := []

var keyLetter := ""

var alreadyGuessed := []

var score := 0

var positionDictionary := {}

var stringLength := 0

var maxScore := 0

var speed := 0.05

var newTier := ""

var pangramChosen = false

var currentTier := "Beginner"


# Called when the node enters the scene tree for the first time.
func _ready():
	var fullDictionaryFile := FileAccess.open(fullDictPath, FileAccess.READ)
	fullParsedFile = JSON.parse_string(fullDictionaryFile.get_as_text())



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
		#var screenSize: Vector2 = (DisplayServer.window_get_size(DisplayServer.window_get_current_screen()))
	pass

