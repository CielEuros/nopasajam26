class_name ScoreController
extends Node

signal no_more_actions

@export var actions_remaining := 10
var found: Array[Hint] = Array()

var proof1: Hint = null
var proof2: Hint = null
var proof3: Hint = null
var recommend_arrest: bool = false

# Attempt to spend some action points, returning false if not enough points remaining.
# Typically used when there is no Hint to be found behind the action spend.
func spend(cost: int) -> bool:
	if cost > actions_remaining:
		return false
	actions_remaining -= cost
	if actions_remaining == 0:
		no_more_actions.emit()
	return true

# Spend action points to find a given Hint, provided the player still has enough
# points. The cost is read from the Hint object.
func spend_and_find(hint: Hint) -> bool:
	var cost = hint.cost
	if cost <= actions_remaining:
		found.append(hint)
		return spend(cost)
	return false

func has_found_major_hint() -> bool:
	for f in found:
		if f.major:
			return true
	return false
	
func select_proof1(hint: Hint) -> Hint:
	var h = proof1
	proof1 = hint
	return h

func select_proof2(hint: Hint) -> Hint:
	var h = proof2
	proof2 = hint
	return h

func select_proof3(hint: Hint) -> Hint:
	var h = proof3
	proof3 = hint
	return h
