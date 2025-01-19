extends Label

var time = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GameTime.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = str(time)


func _on_game_time_timeout() -> void:
	time+=1
