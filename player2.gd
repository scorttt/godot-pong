extends CharacterBody2D

const SPEED = 50.0;
var isAiPlayer: bool = true;
var onRightSide: bool = false;
var paddleSlowRate: float = 0.25;

@onready var ball = %Ball;
@onready var paddle = %Paddle;

func _physics_process(delta):
	var paddleHeight: float = paddle.scale.y / 2;

	onRightSide = true if ball.global_position.x > get_viewport_rect().size.x / 1.5 else false;
		
	if Input.is_action_pressed("p2_move_up") || Input.is_action_pressed("p2_move_down"):
		isAiPlayer = false;
	
	if !isAiPlayer:
		if Input.is_action_pressed("p2_move_down"):
			velocity.y += 1;
		if Input.is_action_pressed("p2_move_up"):
			velocity.y -= 1;
	else:
		if ball.global_position.y + (paddleHeight / 2) < paddle.global_position.y:
			if onRightSide:
				velocity.y -= 1.0;
			else:
				velocity.y -= 0.5;
		elif ball.global_position.y - (paddleHeight / 2) > paddle.global_position.y:
			if onRightSide:
				velocity.y += 1.0;
			else:
				velocity.y += 0.5;
		else:
			velocity.y = 0;

	position += velocity * SPEED * delta;

	var screenTop: float = paddleHeight;
	var screenBottom: float = get_viewport_rect().size.y - paddleHeight;

	position.y = clamp(position.y, screenTop, screenBottom);
	if position.y == screenTop:
		velocity.y = 0;
	if position.y == screenBottom:
		velocity.y = 0;

	if velocity.y != 0:
		if velocity.y > 0:
			velocity.y -= paddleSlowRate;
		elif velocity.y < 0:
			velocity.y += paddleSlowRate;
		if abs(velocity.y) < 0.05:
			velocity.y = 0;
