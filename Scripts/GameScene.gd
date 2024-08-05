extends Control


#var pangramPath := "res://Data/pangramDictionary.json"
#var json_as_text = FileAccess.get_file_as_string(file)
#var pangramDict = JSON.parse_string(file)
#if json_as_dict:
	#print(json_as_dict)
var testPath := "res://Data/sameUniqueLettersTest.json"

var fullDictPath := "res://Data/fullDictionary.json"

var allPangramsDict := []

var pangramMain := {}

var totalPangrams := []

var todaysDictionary := []

var todaysWordsArray := []

var keyLetter := ""

var alreadyGuessed := []

var score := 0

var positionDictionary := {}





# Called when the node enters the scene tree for the first time.
func _ready():
	
# Read Pangram JSON
	#var pangramDictionaryFile := FileAccess.open(pangramPath, FileAccess.READ)
	#var pangramParsedFile = JSON.parse_string(pangramDictionaryFile.get_as_text())
	
# Read Full Dictionary JSON
	var fullDictionaryFile := FileAccess.open(fullDictPath, FileAccess.READ)
	var fullParsedFile = JSON.parse_string(fullDictionaryFile.get_as_text())
	
	
	#var testFile = FileAccess.open(testPath, FileAccess.READ)
	#var testParsedFile = JSON.parse_string(testFile.get_as_text())
	#
	#print("testParsedFile: " + type_string(typeof(testParsedFile)))
	filterPangrams(fullParsedFile, allPangramsDict)
	
	#pangramMain = getNewPangram(allPangramsDict)
	
	pangramMain = allPangramsDict[1]
	
	#keyLetter = getkeyLetter(pangramMain.uniqueChars)
	
	keyLetter = "i"
	
	
	#getTotalPangrams(pangramParsedFile, pangramMain.uniqueChars)
	
	getTodaysDictionary(fullParsedFile, pangramMain.uniqueChars, keyLetter, todaysWordsArray, todaysDictionary)
	
	# Create a dictionary of each word today and their position in todaysWordsArray
	getArrayPosition(todaysWordsArray, positionDictionary)
	
	print()
	
	print("center Letter: " + keyLetter)
	
	print("pangram: " + pangramMain.word)
	
	#if test.all(func(value: String): return value in pangramMain.uniqueChars):
		#print("all values are in pangram")
	#else :
		#print("did not work as expected")
	
	#var matchTest = testParsedFile[0].uniqueChars

	
	#for  i in testParsedFile.size():
		#if testParsedFile[i].uniqueChars == matchTest:
			#totalPangrams.append(testParsedFile[i].word)
			#print("matched with test")
		#else:
			#print("failed to match with test")
			#
	print("total pangrams: " + str(totalPangrams))
	print("total words: " + str(todaysWordsArray))
	
	var submission := str($LineEdit.text)
	_on_line_edit_text_submitted(submission)
	


	
	
	#print("pangram info: " + str(fullParsedFile.filter(fullParsedFile.word == pangramMain)))

	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

# Filter Pangrams out from the array of all words and append them to another array
func filterPangrams(jsonArray, newArray):
	for i in jsonArray.size():
		if jsonArray[i].pangram == true:
			newArray.append(jsonArray[i])
		else:
			pass
	return newArray

# Randomly picks a pangram from the array
func getNewPangram(jsonArray):
	return jsonArray[randi() % jsonArray.size()]

# Randomly picks the keyLetter from the chosen pangram
func getkeyLetter(pangramCharsArray):
	return pangramCharsArray[randi() % pangramCharsArray.size()]

# Function designed to filter through an array of pangram dictionaries and 
# return only other pangrams that match the unique letters of the pangram
# CURRENTLY NOT IN USE
# This is because the pangrams are currently stored in the same array as all
# other words, and simply have a key/value pair in the dictionary denoting 
# whether or not they are pangrams (True/False)
#func getTotalPangrams(jsonArray, pangramChars):
	#for i in jsonArray.size():
		#if jsonArray[i].uniqueChars == pangramChars:
			#totalPangrams.append(jsonArray[i].word)
		#else:
			#pass
	#return
	




# A function that filters through the array of all words and returns ONLY
# words whose uniqueChars are included in the uniqueChars of the pangramMain
func getTodaysDictionary(fullJsonArray, pangramChars, mainLetter, wordsArray, dictArray):
	for i in fullJsonArray.size():
		if fullJsonArray[i].uniqueChars.has(mainLetter):
			if fullJsonArray[i].uniqueChars.all(func(value: String): return value in pangramChars):
				dictArray.append(fullJsonArray[i])
				wordsArray.append(fullJsonArray[i].word)
			else :
				pass
		else :
			pass
	return


# A function designed to create a dictionary of words and their position relative
# to the newly edited array todaysWordsArray
func getArrayPosition(todaysArray, dictionary):
	for i in todaysArray.size():
		dictionary[(todaysArray[i])] = i
	return


# , wordsArray, alreadyGuessedArray, positionDictionary, dictArray

#todaysWordsArray, alreadyGuessed, positionDictionary, todaysDictionary

func _on_line_edit_text_submitted(newText):
	if newText in todaysWordsArray and not alreadyGuessed.has(newText):
		print(type_string(typeof(newText)))
		print("the submission is in todaysWordsArray")
		
		#var test = file.find(file.word == newText)
		#print(test)
		alreadyGuessed.append(newText)
		#print(str(positionDictionary.newText))
		#print(str(dictArray))
	elif newText in alreadyGuessed:
		print("already guessed")
	else:
		print("the submission is not in todaysWordsArray")
	$LineEdit.text = ""
	
	 # Replace with function body.
