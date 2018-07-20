extends KinematicBody2D

var motion = Vector2()
const UP = Vector2(0, -1)
onready var ANIM = $Sprite
var jump = false

const MAX_VEL = 2500
const FALL_ACCELERATOR = 500
const JUMP_HEIGHT = 300
const RUN_SPEED = 100

func _physics_process(delta):
    motion.x = 0

    if motion.y < MAX_VEL:
        motion.y += FALL_ACCELERATOR * delta

    if Input.is_action_pressed('ui_right'):
        motion.x = RUN_SPEED
        ANIM.flip_h = false

    if Input.is_action_pressed('ui_left'):
        motion.x = -RUN_SPEED
        ANIM.flip_h = true

    if is_on_floor():
        jump = false
        if Input.is_action_pressed("ui_up"):
            ANIM.frame = 0
            jump = true
            motion.y = -JUMP_HEIGHT

    motion = move_and_slide( motion, UP )

    if jump:
        ANIM.play('jump')
    elif motion.x != 0:
        ANIM.play('run')
    else:
        ANIM.play('idle')
