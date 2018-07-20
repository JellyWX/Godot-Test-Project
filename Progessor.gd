extends Area2D

export(String, FILE, '*.tscn') var next_level

func _ready():
    connect('body_entered', self, 'on_body_entered')

func on_body_entered(body):
    if body.get_name() == 'Player':
        get_tree().change_scene(next_level)
