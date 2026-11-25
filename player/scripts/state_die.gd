class_name State_Die extends State

## What happens when the player enters this State?
func Enter() -> void:
	player.UpdateAnimation("die") 
	#print("entered die state")

func Physics( _delta : float) -> State:
	return null 
	
## What happens with input events in this State?
func Process( _delta : float ) -> State:
	return null
	
func HandleInput( _event: InputEvent ) -> State:
	return null
	
	## What happens when the player exits this State?
func Exit() -> void:
	pass
