extends KinematicBody2D

var motion = Vector2()
const UP = Vector2(0, -1)
onready var ANIM = $Sprite
var jump = false

func _physics_process(delta):
    motion.x = 0

    if motion.y < 2500:
        motion.y += 500*delta

    if Input.is_action_pressed('ui_right'):
        motion.x = 100
    if Input.is_action_pressed('ui_left'):
        motion.x = -100

    if is_on_floor():
        jump = false
        if Input.is_action_pressed("ui_up"):
            ANIM.frame = 0
            jump = true
            motion.y = -250

    motion = move_and_slide( motion, UP )

    if motion.x > 0:
        ANIM.flip_h = false
    elif motion.x < 0:
        ANIM.flip_h = true

    if jump:
        ANIM.play('jump')
    elif motion.x != 0:
        ANIM.play('run')
    else:
        ANIM.play('idle')
