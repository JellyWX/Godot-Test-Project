extends KinematicBody2D

var motion = Vector2()
var stopping = false
const UP = Vector2(0, -1)
onready var ANIM = $Sprite

const MAX_VEL = 2500
const FALL_ACCELERATOR = 20
const RUN_ACCELERATOR = 45
const JUMP_HEIGHT = 450
const RUN_SPEED = 120

func _physics_process(delta):
    stopping = false

    if motion.y < MAX_VEL:
        motion.y += FALL_ACCELERATOR

    if Input.is_action_pressed('ui_right'):
        motion.x += RUN_ACCELERATOR
        ANIM.flip_h = false

    elif Input.is_action_pressed('ui_left'):
        motion.x -= RUN_ACCELERATOR
        ANIM.flip_h = true

    else:
        stopping = true

    motion.x = clamp(motion.x, -RUN_SPEED, RUN_SPEED)

    if is_on_floor():
        if motion.x != 0:
            ANIM.play('run')
        else:
            ANIM.play('idle')

        if Input.is_action_pressed('ui_up'):
            motion.y = -JUMP_HEIGHT

        if stopping:
            motion.x = lerp(motion.x, 0, 0.2)

    else:
        ANIM.play('jump')
        ANIM.stop()
        if motion.y > 0:
            ANIM.frame = 3
        else:
            ANIM.frame = 0

    motion = move_and_slide( motion, UP )
