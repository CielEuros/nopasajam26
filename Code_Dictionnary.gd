extends Node

#"ID" {
		#"description": "",
		#"is_sufficient_proof":,
		#"scene_image": "",
		#"preview_image": ""
	#},

const DATABASE = {
	"1884" : {
		"description": "Livre revolutionnaire",
		"is_sufficient_proof": true,
		"scene_image": "res://Assets/INDICE_ICONE/1984_MINIA.png",
		"preview_image": "res://Assets/INDICE_ICONE/1984.png"
	},
	"Brique_de_lait": {
		"description": "Une brique de lait moisie",
		"is_sufficient_proof": false,
		"scene_image": "res://Assets/INDICE_ICONE/BRIQUE_LAIT_MINIA.png",
		"preview_image": "res://Assets/INDICE_ICONE/BRIQUE_LAIT.png"
	},
	"Livre_Noir" : {
		"description": "Crypto",
		"is_sufficient_proof": true,
		"scene_image": "res://Assets/INDICE_ICONE/LIVRE_NOIR_MINIA.png",
		"preview_image": "res://Assets/INDICE_ICONE/LIVRE_NOIR.png"
	},
	"Machine_Ecrire": {
		"description": "Une machine à écrire",
		"is_sufficient_proof": false,
		"scene_image": "res://Assets/INDICE_ICONE/MACHINE_A_ECRIRE_MINIA.png",
		"preview_image": "res://Assets/INDICE_ICONE/MACHINE_A_ECRIRE.png"
	}
}

# La memoire de la partie : les IDs trouves dans l'ordre exact
var _found_clues: Array[String] = ["1884","Brique_de_lait","Livre_Noir","Machine_Ecrire"]

# Appelee par la Scene Enquete
func register_found_clue(id: String) -> void:
	if not DATABASE.has(id):
		print("Erreur : L'ID ", id, " n'existe pas dans la base de données.")
		return
	if _found_clues.has(id): 
		return 
	_found_clues.append(id)

# Appelee par Interactible
func get_found_clues_data() -> Array[Dictionary]:
	var result: Array[Dictionary] = []
	for id in _found_clues:
		var data: Dictionary = DATABASE[id].duplicate()
		data["id"] = id # On injecte l'ID
		result.append(data)
	return result

func reset() -> void:
	_found_clues.clear()
