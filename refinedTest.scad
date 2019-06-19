$fn=200;

//standard id size 85.60 × 53.98 mm
length = 58;
width= 85.60;
heightCard = .85;
lengthCard = 1.5;
widthCard = 1.5;
height = length;
cornerRadius = 10;

piCameraWidth = 23.862;
piCameraLength = 25;
piCornerRadius = 2;
piBottomHoleToCenter = 14.5;
piTopHoleToCenter = 2.0;
piHoleSideToCenter = piTopHoleToCenter;
holesSize = 2;

// Sensor is square.
sensorSize = 8.55;

sensorCenterPositionA = 9.462;
sensorCenterPositionB = 12.5;
connectorCenterA = 12;
connectorCenterB = 5;

connectorWidth = 4;
connectorLength = 12;
connectorHeight = 3;

ribbonCableLength = 8.5;
ribbonCableWidth = 3;

difference(){
  peiceOne();
  piCameraInPlace();
}
//peiceTwo();

module cardHolderSlot(){
    cube(size=[widthCard, lengthCard, height-4]);
}
module piCameraInPlace(){
    translate([width+5,length-11.5,height-piCameraLength+10]){
        rotate(a=[0,90,180]) {
            piCamera();
        }
    } 
}

module piCamera(){
    translate([2,2,0]){
        roundedBox(piCameraLength, piCameraWidth,1, piCornerRadius);
        mountingHole();
        translate([0,21,0]) {
            mountingHole();
        }
        translate([piBottomHoleToCenter-holesSize,0,0]) {
            mountingHole();
        }    
        translate([piBottomHoleToCenter-holesSize,21,0]) {
            mountingHole();
        }
    }
    
    translate([sensorCenterPositionA,sensorCenterPositionB-sensorSize/2, 1]){
         color("black") squareBox(sensorSize,sensorSize,connectorHeight-0.25);
         translate([0,0,connectorHeight-0.25]){
            color("red") squareBox(sensorSize, sensorSize, 4.25-connectorHeight);
        }
        color("orange") translate([sensorSize/2,sensorSize/2,4]) {
            cylinder(h = 1.0, r1 = (sensorSize-1)/2, r2 = (sensorSize-1)/2, center = false);
        }        
    }
    translate([connectorCenterB-connectorWidth/2, connectorCenterA-connectorLength/2, 1]){
        color("grey") squareBox(connectorLength, connectorWidth, connectorHeight);
    }
    translate([connectorCenterB+1.5, connectorCenterA-3.75, 1]){
        color("grey") squareBox(ribbonCableLength,ribbonCableWidth,connectorHeight);
    }
}


module mountingHole(){
    cylinder(h = 4.02, r1 = holesSize/2 - 0.05, r2 = holesSize/2 - 0.05, center = false);
}

module peiceOne(){
    translate([5, 5, 0]){
        difference() {
            squareBox(length, width, height);
            translate([1,1,1]){
                difference() {
                    squareBox(length-2, width-6, height);
                    slots();                                            
                }
            }            
        }
    }
}

module slots(){
    translate([heightCard,0,0]){
        cardHolderSlot();
     }
    translate([heightCard,length-3.5,0]){
        cardHolderSlot();
     }
}

module peiceTwo(){
    translate([width*2.5, 10, 0]){
        mirror([1,0,0]) {
            squareBox(length, width, 1);
            difference() {
                translate([1,1,0]) {
                    squareBox(length-2, width-8, 4);
                }
                translate([2,2,0]) {
                    squareBox(length-4, width-12, 4);
                }    
            }
        }
    }
}

module squareBox(length, width, height){
    minkowski() {
        cube(size=[width, length, height]);
    }
}

module roundedBox(length, width, height, radius)
{
    dRadius = 2*radius;
    
    //base rounded shape
    minkowski() {
        cube(size=[width-dRadius,length-dRadius, height]);
        cylinder(r=radius, h=0.01);
    } 
}