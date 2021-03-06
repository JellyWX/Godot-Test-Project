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
const MAX_SHAKE = 10

var shake = 0


func on_slope():
    return test_move(transform, Vector2(1, 0)) or test_move(transform, Vector2(-1, 0))

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
        shake = 0

        if motion.x != 0:
            ANIM.play('run')
        else:
            ANIM.play('idle')

        if Input.is_action_pressed('ui_up'):
            motion.y = -JUMP_HEIGHT

        if stopping:
            if not on_slope():
                motion.x = lerp(motion.x, 0, 0.2)
            else:
                motion.x = 0

    else:
        ANIM.play('jump')
        ANIM.stop()
        if motion.y > 0:
            ANIM.frame = 3
            shake = clamp(shake + (1 * delta), 0, MAX_SHAKE)
            $Camera2D.set_offset(Vector2(rand_range(-shake, shake), rand_range(-shake, shake)))

        else:
            ANIM.frame = 0

    motion = move_and_slide( motion, UP )
