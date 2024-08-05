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

var stringLength := 0

var maxScore := 0







# Called when the node enters the scene tree for the first time.
func _ready():
	
	
# Read Full Dictionary JSON
	var fullDictionaryFile := FileAccess.open(fullDictPath, FileAccess.READ)
	var fullParsedFile = JSON.parse_string(fullDictionaryFile.get_as_text())
	
	filterPangrams(fullParsedFile, allPangramsDict)
	
	pangramMain = getNewPangram(allPangramsDict)
	
	keyLetter = getkeyLetter(pangramMain.uniqueChars)
	
	getTodaysDictionary(fullParsedFile, pangramMain.uniqueChars, keyLetter, todaysWordsArray, totalPangrams)
	
	maxScore = calculatePossiblePoints(todaysWordsArray, totalPangrams)
	
	# Create a dictionary of each word today and their position in todaysWordsArray
	#getArrayPosition(todaysWordsArray, positionDictionary)
	
	print("center Letter: " + keyLetter)
	
	print("pangram: " + pangramMain.word)
	
	print("total pangrams: " + str(totalPangrams))
	print("total words: " + str(todaysWordsArray))
	print("count of words: " + str(todaysWordsArray.size()))
	print("max score: " + str(maxScore))
	

	




func _process(_delta):
	
	
	if Input.is_action_just_pressed("ui_text_submit"):
		var submission := str($LineEdit.text)
	#if Input.is_key_pressed(KEY_ENTER):
		if submission in todaysWordsArray and not alreadyGuessed.has(submission):
			print("the submission is in todaysWordsArray")
			stringLength = submission.length()
			alreadyGuessed.append(submission)
			$LineEdit.text = ""
			score += assignPoints(stringLength, submission)
			print(score)
			return true
		elif submission in alreadyGuessed:
			print("already guessed")
			$LineEdit.text = ""
		else:
			print("the submission is not in todaysWordsArray")
			$LineEdit.text = ""
		
		


############## FUNCTIONS ###############

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




# A function that filters through the array of all words and returns ONLY
# words whose uniqueChars are included in the uniqueChars of the pangramMain
func getTodaysDictionary(fullJsonArray, pangramChars, mainLetter, wordsArray, pangramArray):
	for i in fullJsonArray.size():
		if fullJsonArray[i].uniqueChars.has(mainLetter):
			if fullJsonArray[i].uniqueChars.all(func(value: String): return value in pangramChars):
				#dictArray.append(fullJsonArray[i])
				wordsArray.append(fullJsonArray[i].word)
				if fullJsonArray[i].uniqueChars == pangramChars:
					pangramArray.append(fullJsonArray[i].word)
			else :
				pass
		else :
			pass
	return




# A function designed to create a dictionary of words and their position relative
# to the newly edited array todaysWordsArray
#func getArrayPosition(todaysArray, dictionary):
	#for i in todaysArray.size():
		#dictionary[(todaysArray[i])] = i
	#return


	
# Assigning points, including extra for pangrams
func assignPoints(strLength, word):
	var points := 0
	if strLength == 4:
		points = 1
	elif strLength >= 7 and totalPangrams.has(word):
		points = strLength + 7
		print("pangram!")
	else :
		points = strLength
	return points

func calculatePossiblePoints(array, pangramArray):
	var total : int = pangramArray.size() * 7
	print("total pangram bonus points: " + str(total))
	for i in array.size():
		if array[i].length() > 4:
			total += array[i].length()
			print(str(i) + ": " + str("1 point"))
		else:
			total += 1
			print(str(i) + ": " + str(array[i].length()) + " points")
	return total

