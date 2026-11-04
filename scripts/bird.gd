extends CharacterBody2D

var JUMP_VELOCITY = -400.0
signal  died
var is_alive=true
signal started
var first=true
signal update_score
var angle_limit=-1
@onready var flap: AudioStreamPlayer2D = $flap


func _physics_process(delta: float) -> void:
	if first:
		position.x=-117.0 #the bird x position during the start
		position.y=274.0 #teh bird y position during the start
	if not is_on_floor() and not first:
		velocity.y+=get_gravity().y *delta
	if Input.is_action_just_pressed("jump") and is_alive:
		if first:
			first=false
			started.emit()
		velocity.y=JUMP_VELOCITY
		flap.play()
	if Input.is_action_pressed("jump") and is_alive:
		rotation = move_toward(rotation, angle_limit, 3 * delta)
	else:
		rotation = move_toward(rotation, 0.0, 3 * delta)
	move_and_slide()
	
func die():
	if is_alive:
		is_alive=false	
	died.emit()	
func update():
	update_score.emit()
		
