extends Node3D

@onready var jugador1 = $CartasJugador1
@onready var jugador2 = $CartasJugador2

enum Turno { JUGADOR1, JUGADOR2, FINAL }
var turno_actual : Turno = Turno.JUGADOR1
var ronda_terminada := false

func _ready():
	print("Turno de Jugador 1")

	jugador1.set_process_input(true)
	jugador2.set_process_input(false)

func _input(event):
	if event.is_action_pressed("ui_accept") and not ronda_terminada:
		match turno_actual:
			Turno.JUGADOR1:
				jugador1.set_process_input(false)
				jugador2.set_process_input(true)
				turno_actual = Turno.JUGADOR2
				get_tree().current_scene.mover_camara_a_jugador(.25)
				print("Turno de Jugador 2")
			Turno.JUGADOR2:
				jugador2.set_process_input(false)
				evaluar_ronda()
				turno_actual = Turno.FINAL

func evaluar_ronda():
	var aciertos_j1 = jugador1.evaluar_resultado()
	var aciertos_j2 = jugador2.evaluar_resultado()

	print("Jugador 1 acertó:", aciertos_j1)
	print("Jugador 2 acertó:", aciertos_j2)

	if aciertos_j1 > aciertos_j2:
		print("¡Jugador 1 gana la ronda!")
	elif aciertos_j2 > aciertos_j1:
		print("¡Jugador 2 gana la ronda!")
	else:
		print("¡Empate!")
