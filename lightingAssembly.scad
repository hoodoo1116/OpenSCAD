// Peice Dimensions
cobWidth = 8;
cobEndWidth = 11;
cobLength = 50;
cobEndlength = 56;

cobDepth = 5.5;

batteryTerminalSpace = 1;

batteryHolderLength = 52;
batteryHolderWidth = 31.5;
batteryHolderHeight = 14;
batteryHolderDepth = 12;
batteryDiameter = 10;
batteryHeight = 43;

lightCobWidth = 8;
ligthCobLength=60;
lightCobHeight = 2;
lightCobAttachementPoint = 3;
lightCobAttachementHoldDiameter = 2;

diffuser=1.5;

switchWidth = 6;
switchHeight = 13.5;
switchAttachmentDepth = 1;
switchAttachmentLength = 19.56;
switchAttachmentWidth = 4.5;
switchAttachemtnHoleDiameter = 3;


switchBodyLength = 11.75;
switchBodyHeight = 5;
switchPinsWidth = 1.5;
switchPinsHeight = 3;

switchLeverLengthWidth = 3;
switchLeverHeight = 5;

//Renders;
batteryBox();

module batteryBox(){
    translate([5,5,0]){
        difference() {
            roundedBox(batteryHolderHeight+2, batteryHolderWidth+2, batteryHolderLength+2,5);
            translate([1,1,1]) {
                difference() {
                    roundedBox(batteryHolderHeight, batteryHolderWidth, batteryHolderLength,5);
                    translate([0,5,0]){
                    squareBox(batteryDiameter,1,batteryTerminalSpace+.5);
                    }
                }
            }
            translate([5,-5,-1]){
                squareBox(10, batteryHolderWidth+15, batteryHolderHeight+45); 
            }
        }
    }
}

//Helper Functions
module squareBox(length, width, height){
    cube(size=[length, width, height]);
}

module roundedBox(length, width, height, radius) {
    dRadius = 2*radius;
    
    //base rounded shape
    minkowski() {
        cube(size=[length-dRadius,width-dRadius, height]);
        cylinder(r=radius, h=0.01);
    } 
}



