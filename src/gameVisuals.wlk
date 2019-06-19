object visual {
	const _type = self.fillTypes()
	
	method fillTypes() {
		const type = new Dictionary()
		//Player:
		type.put("bobby","./tiles/player/bobbyCarrot.png")
		type.put("deadBobby","./tiles/player/bobbyCarrot.png")
		
		//Obstacles:
			//Fences:
			type.put("horizontalFence","./tiles/fences/horizontalFence.png")
			type.put("verticalFence","./tiles/fences/verticalFence.png")
			type.put("bottomLeftFence","./tiles/fences/bottomLeftFence.png")
			type.put("bottomRightFence","./tiles/fences/bottomRightFence.png")
			type.put("topLeftFence","./tiles/fences/topLeftFence.png")
			type.put("topRightFence","./tiles/fences/topRightFence.png")
			
			//Grasses:
			type.put("lonelyGrass","./tiles/grass/lonelyGrass.png") 
			type.put("middleGrass","./tiles/grass/middleGrass.png")
			type.put("grass1","./tiles/grass/1.png")
			
		
		//Grabables:
		type.put("carrot","./tiles/ground/carrot.png")
		type.put("egg","./tiles/ground/egg.png")
		type.put("goldKey","./tiles/keys/goldKey.png")
		type.put("silverKey","./tiles/keys/silverKey.png")
		type.put("redKey","./tiles/keys/redKey.png")
		
		//Walkable:
			//Deafult Ground:
			type.put("ground","./tiles/ground/ground.png")
			//After Grab:
			type.put("emptyNest","./tiles/ground/emptyNest.png")
			type.put("groundHole","./tiles/ground/groundHole.png")
			
			//Points:
			type.put("startPoint","./tiles/points/spawnPoint.png")
			type.put("endPointOn","./tiles/points/endPointOn.png")
			type.put("endPointOff","./tiles/points/endPointOff.png")
			
		
		//dynamicObstacles:
			//Runaways:
				//L shape:
				type.put("leftDownRunaway","./tiles/runaways/leftDownRunaway.png")
				type.put("leftUpRunaway","./tiles/runaways/leftUpRunaway.png")
				type.put("rightUpRunaway","./tiles/runaways/rightUpRunaway.png")
				type.put("rightDownRunaway","./tiles/runaways/rightDownRunaway.png")
				
				//Straight Shape:
				type.put("horizontalRunaway","./tiles/runaways/horizontalRunaway.png")
				type.put("vertcalRunaway","./tiles/runaways/verticalRunaway.png")
				
			//Transport Belts:
			type.put("upBelt","./tiles/belts/upBelt.png")
			type.put("downBelt","./tiles/belts/downBelt.png")
			type.put("leftBelt","./tiles/belts/leftBelt.png")
			type.put("rightBelt","./tiles/belts/rightBelt.png")
			
			//Locks
			type.put("goldLock","./tiles/locks/goldLock.png")
			type.put("silverLock","./tiles/locks/silverLock.png")
			type.put("redLock","./tiles/locks/redLock.png")
			
			return type
	}
	
	method get(tile) {
		_type.getOrElse (tile,{=> _type.get("middleGrass")})
	}
}