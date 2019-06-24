object assets {
	const graphics = self.fillGraphicsDictionary()
	
	method fillGraphicsDictionary() {
		const tempGraphics = new Dictionary()
		//Missing Graphics
		tempGraphics.put("assetNotFound","./assetNotFound.png")
		
		//Player:
		tempGraphics.put("bobby","./bobby/bobby.png")
		tempGraphics.put("deadBobby","./bobby/deadBobby.png")
		
		//Obstacles:
			//Fences:
			tempGraphics.put("horizontalFence","./tiles/fences/horizontalFence.png")
			tempGraphics.put("verticalFence","./tiles/fences/verticalFence.png")
			tempGraphics.put("bottomLeftFence","./tiles/fences/bottomLeftFence.png")
			tempGraphics.put("bottomRightFence","./tiles/fences/bottomRightFence.png")
			tempGraphics.put("topLeftFence","./tiles/fences/topLeftFence.png")
			tempGraphics.put("topRightFence","./tiles/fences/topRightFence.png")
			
			//Grasses:
			tempGraphics.put("lonelyGrass","./tiles/grass/lonelyGrass.png") 
			tempGraphics.put("middleGrass","./tiles/grass/middleGrass.png")
			tempGraphics.put("grass1","./tiles/grass/1.png")
			
		
		//Grabables:
		tempGraphics.put("carrot","./tiles/ground/carrot.png")
		tempGraphics.put("egg","./tiles/ground/egg.png")
		tempGraphics.put("goldKey","./tiles/keys/goldKey.png")
		tempGraphics.put("silverKey","./tiles/keys/silverKey.png")
		tempGraphics.put("redKey","./tiles/keys/redKey.png")
		
		//Walkable:
			//Deafult Ground:
			tempGraphics.put("ground","./tiles/ground/ground.png")
			//After Grab:
			tempGraphics.put("emptyNest","./tiles/ground/emptyNest.png")
			tempGraphics.put("groundHole","./tiles/ground/groundHole.png")
			
			//Points:
			tempGraphics.put("startPoint","./tiles/points/spawnPoint.png")
			tempGraphics.put("endPointOn","./tiles/points/endPointOn.png")
			tempGraphics.put("endPointOff","./tiles/points/endPointOff.png")
			
		
		//dynamicObstacles:
			//Runaways:
				//L shape:
				tempGraphics.put("leftDownRunaway","./tiles/runaways/leftDownRunaway.png")
				tempGraphics.put("leftUpRunaway","./tiles/runaways/leftUpRunaway.png")
				tempGraphics.put("rightUpRunaway","./tiles/runaways/rightUpRunaway.png")
				tempGraphics.put("rightDownRunaway","./tiles/runaways/rightDownRunaway.png")
				
				//Straight Shape:
				tempGraphics.put("horizontalRunaway","./tiles/runaways/horizontalRunaway.png")
				tempGraphics.put("vertcalRunaway","./tiles/runaways/verticalRunaway.png")
				
			//Transport Belts:
			tempGraphics.put("upBelt","./tiles/belts/upBelt.png")
			tempGraphics.put("downBelt","./tiles/belts/downBelt.png")
			tempGraphics.put("leftBelt","./tiles/belts/leftBelt.png")
			tempGraphics.put("rightBelt","./tiles/belts/rightBelt.png")
			
			//Locks
			tempGraphics.put("goldLock","./tiles/locks/goldLock.png")
			tempGraphics.put("silverLock","./tiles/locks/silverLock.png")
			tempGraphics.put("redLock","./tiles/locks/redLock.png")
			
			return tempGraphics
	}

	method get(graphic) = graphics.getOrElse (graphic,{=> graphics.get("assetNotFound")})
}