extends Node


# Condiciones del juego
var talked_to = {
	"Hermana": false,
	"Yayo": false,
	"Madre": false
}

var invitados_viesta = {
	"Hermana": false,
	"Yayo": false,
	"Marga": false
}


# Diccionarios NPCs de conversaciones
var madre_dict = {
	"next": "start",
}

var hermana_dict = {
	"next": "start",
}

var yayo_dict = {
	"next": "start",
	"amount_talk_river": 0
}
