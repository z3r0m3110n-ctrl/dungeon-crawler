class_name State extends Node

## Stores a reference to the player that this State belongs to
static var player: Player
	
	
func Physics( _delta : float) -> State:
	return null 
	
## What happens with input events in this State?
func Process( _delta : float ) -> State:
	return null
	
func HandleInput( _event: InputEvent ) -> State:
	return null
