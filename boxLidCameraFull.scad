$fn=200;

wallAThickness = 3.5;
wallBThickness = 3.5;
baseWidth = 55;
baseCameraSideThickness = 6;
baseCardSideThickness = 3.5;
floorThickness = 3.5;
baseLength = 78;

modifierPercent = 0.20;
length = baseLength + baseCameraSideThickness + baseCardSideThickness; // x
width = baseWidth + wallAThickness + wallBThickness; // y
height = length; // z

lidHeight = 4;

heightCard = 1.75;
lengthCard = 1.75;
widthCard = 1.75;

cornerRadius = 10;

piBoardHeight = 1.5;
piCameraWidth = 25;
piCameraLength = 25.25;
piCornerRadius = 2;
piBottomHoleToCenter = 14.5;
piTopHoleToCenter = 2.0;
piHoleSideToCenter = piTopHoleToCenter;
holesSize = 2;

// Sensor is square.
sensorSize = 9;
sensorHeight = 4;

sensorCenterPositionA = 9.46;
sensorCenterPositionB = 12.5;
connectorCenterA = 12;
connectorCenterB = 5;

connectorWidth = 7;
connectorLength = 12;
connectorHeight = 3;

ribbonCableLength = 12;
ribbonCableWidth = 3;

switchDepth = 11;
switchTrigger = 6; 
switchHeight = 6;
switchWidth = 22;    
center = 3.25;
centerSide = 5.5;


difference(){
    translate([switchDepth,0,0]) {
        rotate(a=[90,0,90]) {
            difference(){
                boxMain();
                piCameraInPlace();
            }
        }   
    }
    microswitchHole();
}

translate([0,0,switchDepth]) {
    mirror([0,1,0]){
        rotate(a=[90,0,0]) {
            microswitch();
        }
    }
}

  
module cardHolderSlot(){
    modHeight = height - (height * modifierPercent);
    cube(size=[widthCard, lengthCard, modHeight-lidHeight-floorThickness]);
}
module piCameraInPlace(){
    translate([length+0.5,(width/2)+(piCameraWidth/2),(height/4)+piCameraLength]){
        rotate(a=[0,90,180]) {
            piCamera();
        }
    } 
}

module piCamera(){
    translate([2,2,0]){
        roundedBox(piCameraLength, piCameraWidth,piBoardHeight, piCornerRadius);
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
    
    translate([sensorCenterPositionA,sensorCenterPositionB-sensorSize/2, piBoardHeight]){
        color("red") squareBox(sensorSize, sensorSize, piBoardHeight+connectorHeight);
        color("orange") translate([sensorSize/2,sensorSize/2, sensorHeight]) {
            cylinder(h = piBoardHeight, r1 = (sensorSize-1)/2, r2 = (sensorSize-1)/2, center = false);
        }        
    }
    translate([connectorCenterB/2, connectorCenterA/2, piBoardHeight]){
        color("grey") squareBox(connectorLength, connectorWidth, connectorHeight);
    }
}


module mountingHole(){
    cylinder(h = 4.02, r1 = holesSize/2 - 0.05, r2 = holesSize/2 - 0.05, center = false);
}

module boxMain(){
    difference() {
        modHeight = height-(height * modifierPercent);
        squareBox(width, length, modHeight);
        translate([wallAThickness, wallBThickness, floorThickness]){
            difference() {
                squareBox(baseWidth, baseLength, modHeight);
                slots();                                            
            }
        }
    }            
}

module slots(){
    translate([heightCard,0,0]){
        cardHolderSlot();
     }
    translate([heightCard,baseWidth-wallBThickness+widthCard,0]){
        cardHolderSlot();
     }
}

module boxLid(){
    translate([0, width*2.5, 0]){
        mirror([0,1,0]) {
            difference() {
                squareBox(width, length, 2);
                translate([wallAThickness,baseCardSideThickness,-1]){
                    squareBox(baseWidth, widthCard,lidHeight+2);
                }
            }
            color("purple") difference() {  
                translate([baseCardSideThickness+lengthCard,wallAThickness,2]){
                    squareBox(baseWidth, baseLength-lengthCard, lidHeight);}
                translate([baseCardSideThickness+2-lengthCard,wallAThickness+2,2]) {
                    squareBox(baseWidth-4, baseLength+lengthCard-4, lidHeight+2);
                }
            }
            translate([wallAThickness+widthCard,baseCardSideThickness+2,2]){
             color("purple") squareBox(baseWidth-4, 2,lidHeight);
            }
        }
    }
}


module microswitch() {
    difference() {
        cube(size=[switchDepth, switchWidth, floorThickness]);    
        translate([center,centerSide+1, 1.5]) {
            mountingHole();
        }
        translate([center, switchWidth-centerSide,1.5]) {
            mountingHole();
        }
    }
}

module microswitchHole() {
    translate([switchDepth-.5, floorThickness, switchDepth]) {
        cube(size=[floorThickness+1, switchHeight, switchWidth]);
    }
}

module squareBox(length, width, height){
    cube(size=[width, length, height]);
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