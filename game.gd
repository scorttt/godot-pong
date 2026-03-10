extends Node2D

var player1Score: int = 0;
var player2Score: int = 0;
@onready var player1ScoreHUD = %ScorePlayer1
@onready var player2ScoreHUD = %ScorePlayer2
@onready var ball = %Ball;


func _on_left_goal_body_entered(body):
	if body.has_method("resetBall"):
		player2Score += 1;
		player2ScoreHUD.text = str(player2Score);
		respawnBall();

func _on_right_goal_body_entered(body):
	if body.has_method("resetBall"):
		player1Score += 1;
		player1ScoreHUD.text = str(player1Score);
		respawnBall();

func respawnBall():
	ball.resetBall();
