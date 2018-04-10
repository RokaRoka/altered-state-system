extends Sprite

export var animating = true
export var fps = 5

var spriteCount
var count = 0

func _ready():
	spriteCount = hframes * vframes

func _process(delta):
	count += delta
	#if time hits the max time based on fps and spriteCount
	
	if count >= float(spriteCount) / fps:
		#print( String(count) + " Sprite count: " + String(spriteCount) + " FPS: " + String(fps) + " " + String(spriteCount / fps))
		count -= count
	
	determineFrame()

func determineFrame():
	frame = int ( floor(count * fps) )