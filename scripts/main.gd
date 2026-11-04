extends Node

@onready var bird: CharacterBody2D = $bird
@onready var upperboundary: Area2D = $upperboundary
@onready var lowerboundary: Area2D = $lowerboundary
@export var pipe_scene : PackedScene
@onready var spawnpoint: Marker2D = $spawnpoint
@onready var retry_button: Button = $retry/retry/retry_button
@onready var deathscreen: CanvasLayer = $deathscreen
@onready var message: Sprite2D = $Message
@onready var score: Label = $score/Control/score
@onready var pipetimer: Timer = $pipetimer
@onready var die: AudioStreamPlayer2D = $die
@onready var final: Label = $"final score/Control/final"


var game_over=false
var current_score=0
var score_to_displayed


func _ready() -> void:
	show_score()
	deathscreen.hide()
	retry_button.hide()
	message.show()
	score.hide()
	pipetimer.stop()
	final.hide()
	
	
	
	
func _physics_process(delta: float) -> void:
	if game_over:
		return
	if lowerboundary.overlaps_body(bird) or upperboundary.overlaps_body(bird):
		game_over=true
		bird.die()
	


func _on_pipetimer_timeout() -> void:
	var pipe=pipe_scene.instantiate()
	add_child(pipe)
	var spawn_x=spawnpoint.global_position.x
	var random_y = randf_range(-150, 150)
	pipe.position = $spawnpoint .position + Vector2(0, random_y)


func _on_bird_died() -> void:
	die.play()
	retry_button.show()
	get_tree().paused=true
	deathscreen.show()
	update_final()
	score.hide()

	


func _on_retry_button_pressed() -> void:
	get_tree().paused=false
	get_tree().reload_current_scene()
	


func _on_bird_started() -> void:
	message.hide()
	score.show()
	pipetimer.start()
	

func _on_bird_update_score() -> void:
	current_score+=1
	show_score()
	
func show_score():
	score_to_displayed=str(current_score)
	score.text=score_to_displayed
	
func update_final():
	final.text="SCORE:"+score_to_displayed
	final.show()
	
		

	

	
