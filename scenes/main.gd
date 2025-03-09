extends Node3D

# Node references
@onready var cube = $Cube
@onready var water = $Water

# Properties
var rotation_speed = 1.0

func _ready():
    # Set up initial camera position
    $Camera3D.position = Vector3(0, 10, 10)
    $Camera3D.look_at(Vector3.ZERO)

func _process(delta):
    # Rotate the cube
    cube.rotate_y(rotation_speed * delta)

func _input(event):
    # Handle camera movement
    if event is InputEventKey:
        var speed = 15.0 * get_process_delta_time()
        if event.pressed:
            match event.keycode:
                KEY_W:
                    $Camera3D.position += -$Camera3D.transform.basis.z * speed
                KEY_S:
                    $Camera3D.position += $Camera3D.transform.basis.z * speed
                KEY_A:
                    $Camera3D.position += -$Camera3D.transform.basis.x * speed
                KEY_D:
                    $Camera3D.position += $Camera3D.transform.basis.x * speed
                KEY_SPACE:
                    $Camera3D.position += Vector3.UP * speed
                KEY_Z:
                    $Camera3D.position += Vector3.DOWN * speed
                KEY_ESCAPE:
                    get_tree().quit()
    
    # Handle mouse look
    elif event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
        var sensitivity = 0.003
        $Camera3D.rotate_x(-event.relative.y * sensitivity)
        $Camera3D.rotate_y(-event.relative.x * sensitivity)
        $Camera3D.rotation.x = clamp($Camera3D.rotation.x, -PI/2, PI/2) 