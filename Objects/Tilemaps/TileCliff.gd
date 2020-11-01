extends TileMap3D

func defineTiles():
	tileDefinitions[CENTER] = ["1,1",
									"2,1",
									"3,1",
									"4,1",
									"1,2",
									"2,2",
									"3,2",
									"4,2",
									"1,3",
									"2,3",
									"3,3",
									"4,3",
									"1,4",
									"2,4",
									"3,4",
									"4,4",
									"9,4",
									"12,4"]
	
	tileDefinitions[BORDER_LEFT] = ["0,1",
										"0,2",
										"0,3",
										"0,4",
										"16,1"]

	tileDefinitions[BORDER_RIGHT] = ["5,1",
										"5,2",
										"5,3",
										"5,4",
										"17,1"]
	
	tileDefinitions[BORDER_TOP] = ["1,0",
										"2,0",
										"3,0",
										"4,0"]
	
	tileDefinitions[BORDER_TOPLEFT] = ["0,0"]

	tileDefinitions[BORDER_TOPRIGHT] = ["5,0"]

	tileDefinitions[WALL] = ["0,5",
							"1,5",
							"2,5",
							"3,5",
							"4,5",
							"5,5"]
