extends Line2D
class_name trail2D

export (bool) var emitting = true
export var pointsCount : int = 20
export (float, 0, 1) var pointsWeight : float = 1.0

var parentGlobalPosSaves = [] # Will contain parent's last positions

func _ready() :
	clear_points()
	show_behind_parent = true

func _process(_delta):
	if emitting :
		majNPoints()
		saveParentPos()
		majPosPoints()
	visible = emitting
	


func saveParentPos() :
	"""
	Saves parent's global_position and correct parentGlobalPosSaves's size to
	trail's points size.
	"""
	parentGlobalPosSaves.push_front(get_parent().global_position)
	while parentGlobalPosSaves.size() - points.size() < 0 :
		parentGlobalPosSaves.push_front(get_parent().global_position)
	while parentGlobalPosSaves.size() - points.size() > 0 :
		parentGlobalPosSaves.pop_back()
	


func majPosPoints() :
	"""
	Update trail points position
	Trail points position are local
	"""
	for i in range(points.size()) :
		if i == 0 :
			points[i] = parentGlobalPosSaves[i] - global_position
		elif i > 0 :
			var newPos = lerp(
				points[i], 
				parentGlobalPosSaves[i] - global_position, 
				pointsWeight
				)
			set_point_position(i, newPos)
		
	


func majNPoints() :
	"""
	Update points number
	"""
	if pointsCount > points.size() :
		addNPoints(pointsCount - points.size())
	elif pointsCount < points.size():
		removeNPoints(points.size() - pointsCount)
	


func addNPoints(nPointsToAdd) :
	"""
	Add points at the end of line
	"""
	print("Adding point")
	for _i in range(nPointsToAdd) :
		var newPoint = Vector2(0,0)
		if points.size() :
			newPoint.x = points[-1].x
			newPoint.y = points[-1].y
		add_point(newPoint)
	


func removeNPoints(nPointsToRem) :
	"""
	Remove points from the end of line
	"""
	print("Adding point")
	for _i in range(nPointsToRem) :
		if not points[-1] :
			return
		else :
			remove_point(points.size() - 1)
		
	



