extends State
class_name PlayerDefault

func Enter():
	pass

func Exit():
	pass

func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
		State_Transition.emit
