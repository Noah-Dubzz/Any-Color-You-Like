// Define an array for enemy spawn conditions and positions
var spawnData;

if (room == rmLevel1) {
    spawnData = [
        [0, 700, 450],
        [1000, 1315, 145],
        [3000, 1250, 630],
        [4000, 630, 920],
        [5000, 630, 150],
        [6000, 1250, 450],
        [7000, 700, 630],
        [8000, 1320, 920]
    ];
}
if (room == rmLevel2) {
    spawnData = [
        [9000, 255, 315],
        [10000, 1665, 185],
        [11000, 1665, 830],
        [12000, 655, 535],
        [13000, 1260, 535],
        [14000, 560, 830],
        [15000, 240, 915],
        [16000, 240, 455],
        [17000, 960, 635]
    ];
}
if (room == rmLevel3) {
    spawnData = [
        [18000, 1740, 560],
        [19000, 1280, 1060],
        [20000, 1740, 1555],
        [21000, 1280, 320],
        [22000, 1740, 320],
        [23000, 1280, 1555],
        [24000, 1280, 560],
        [25000, 1740, 1060],
        [26000, 1500, 1785]
    ];
}
if (room == rmEndless) {
    // Define an array of enemy locations
    var enemyLocations = [
        [1530, 75],
        [1530, 180],
        [1575, 440],
        [1575, 775],
        [1690, 985],
        [1505, 985],
        [1795, 660],
        [1400, 505],
        [1795, 270],
        [1795, 935],
        [1065, 380],
        [890, 380],
        [1400, 710],
        [980, 880],
        [830, 960],
        [1140, 960],
        [565, 710],
        [565, 505],
        [385, 455],
        [385, 885],
        [200, 1025],
        [200, 180],
        [150, 270],
        [150, 375],
        [150, 835],
        [150, 935],
        [345, 605],
        [565, 55],
        [1795, 555]
    ];

    // Choose a random number of enemies to spawn (min 3, max total enemy locations)
    var numEnemiesToSpawn = irandom_range(3, 8);

    // Randomly pick unique spots from the array to spawn enemies
    var chosenLocations = array_create(0); // To store selected locations
    while (array_length(chosenLocations) < numEnemiesToSpawn) {
        var randomIndex = irandom(array_length(enemyLocations) - 1);
        if (!array_contains(chosenLocations, randomIndex)) {
            array_push(chosenLocations, randomIndex);
        }
    }

    // Spawn enemies at the chosen locations
    for (var i = 0; i < array_length(chosenLocations); i++) {
        var loc = enemyLocations[chosenLocations[i]];
        var enx = loc[0];
        var eny = loc[1];
        instance_create_layer(enx, eny, "Instances", objEnemy1);
    }
} else {
    // Normal spawning logic for other rooms
    for (var i = 0; i < array_length(spawnData); i++) {
        var enscore = spawnData[i][0];
        var enx = spawnData[i][1];
        var eny = spawnData[i][2];

        if (global.Score >= enscore) {
            instance_create_layer(enx, eny, "Instances", objEnemy1);
        }
    }
}
if (global.mode = "MultiPrism") {
    // Define an array of enemy locations
	if (room = rmLevel1){
    var enemyLocations = [
        [700, 450],
        [1315, 145],
        [970, 820],
        [1250, 630],
        [630, 920],
        [630, 150],
        [1250, 450],
        [700, 630],
        [1320, 920]
    ];
	}
	if (room = rmLevel2){
    var enemyLocations = [
        [255, 315],
        [1665, 185],
        [1665, 830],
        [655, 535],
        [1260, 535],
        [560, 830],
        [240, 915],
        [240, 455],
        [960, 635]
    ];
	}
	if (room = rmLevel3){
    var enemyLocations = [
        [1740, 560],
        [1280, 1060],
        [1740, 1555],
        [1280, 320],
        [1740, 320],
        [1280, 1555],
        [1280, 560],
        [1740, 1060],
        [1500, 1785]
    ];
	}

    // Choose a random number of enemies to spawn (min 3, max total enemy locations)
    var numEnemiesToSpawn = irandom_range(1, 5);

    // Randomly pick unique spots from the array to spawn enemies
    var chosenLocations = array_create(0); // To store selected locations
    while (array_length(chosenLocations) < numEnemiesToSpawn) {
        var randomIndex = irandom(array_length(enemyLocations) - 1);
        if (!array_contains(chosenLocations, randomIndex)) {
            array_push(chosenLocations, randomIndex);
        }
    }

    // Spawn enemies at the chosen locations
    for (var i = 0; i < array_length(chosenLocations); i++) {
        var loc = enemyLocations[chosenLocations[i]];
        var enx = loc[0];
        var eny = loc[1];
        instance_create_layer(enx, eny, "Instances", objEnemy1);
    }
}

//x = clamp(x, 594 - sprite_width, 1348 - sprite_width);
//y = clamp(y, 111 - sprite_height, 952 - sprite_height);