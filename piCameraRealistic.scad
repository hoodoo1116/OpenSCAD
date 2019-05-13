$fn=200;

slack = 1;
//standard id size 85.60 × 53.98 mm
length = 53.98 + slack;
width= 86.60 + slack;
height = 100;
cornerRadius = 10;

piCameraWidth = 23.862;
piCameraLength = 25;
piCornerRadius = 2;
piBottomHoleToCenter = 14.5;
piTopHoleToCenter = 2.0;
piHoleSideToCenter = piTopHoleToCenter;
holesSize = 2.2;

// Sensor is square.
sensorSize = 8.5;

sensorCenterPositionA = 9.462;
sensorCenterPositionB = 12.5;
connectorCenterA = 11.2;
connectorCenterB = 4.7;

connectorWidth = 4;
connectorLength = 9.5;
connectorHeight = 1.5;

ribbonCableLength = 7;
ribbonCableWidth = 3;
    
       
piCamera();
//difference(){
  //  peiceOne();
    //piCameraInPlace();
//}

module piCameraInPlace(){
    translate([width-piCameraLength,length-5,100]){
        rotate(a=[0,180,180]) {
            piCamera();
        }
    } 
}

module piCamera(){
    translate([2,2,0]){
        difference(){
            difference(){
                difference(){
                    difference(){
                        roundedBox(piCameraLength, piCameraWidth,1, piCornerRadius);
                        mountingHole();
                        }
                    translate([0,21,0]) {
                        mountingHole();
                    }
                }
                translate([piBottomHoleToCenter-holesSize,0,0]) {
                    mountingHole();
                }
            }
            translate([piBottomHoleToCenter-holesSize,21,0]) {
                 mountingHole();
            }
        }
    }
    translate([sensorCenterPositionA,sensorCenterPositionB-sensorSize/2, 1]){
        translate([2,2,0]) {
            color("black") squareBox(5,5,connectorHeight);
        }
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
    translate([connectorCenterB+2, connectorCenterA-2.25, connectorHeight+0.75]){
    color("grey") squareBox(ribbonCableLength,ribbonCableWidth,0.25);
    }
}


module peiceOne(){
    translate([10, 10, 0]){
        difference() {
            squareBox(length, width, height); 
            squareBox(length-2, width-2, height-4); 

        }
    }
}

module mountingHole(){
    cylinder(h = 1.02, r1 = holesSize/2, r2 = holesSize/2, center = false);
}

module peiceTwo(){
    translate([width*2.5, 10, 0]){
        mirror([1,0,0]) {
            squareBox(length, width, 1);
            difference() {
                translate([1,1,0]) {
                    squareBox(length-2, width-2, 4);
                }
                translate([2,2,0]) {
                    squareBox(length-4, width-4, 4);
                }    
            }
        }
    }
}

module squareBox(length, width, height)
{
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