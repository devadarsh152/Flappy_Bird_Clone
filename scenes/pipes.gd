extends Node2D
@onready var point_scored: AudioStreamPlayer2D = $point_scored

signal scored
var speed=100

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("jump")==true and position.x==680:
		position.x-=speed*delta
		if position.x<-700:
			queue_free()
	else:
		position.x-=speed*delta
		if position.x<-700:
			queue_free()		
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.die()
		

		
func _on_score_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		point_scored.play()
		body.update()
		
		
