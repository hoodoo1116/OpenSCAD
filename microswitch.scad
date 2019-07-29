
floorThickness = 3.5;
baseCameraSideThickness = 6;
holesSize = 2;
center = 3.25;
centerSide = 5.5;

microswitch();

module microswitch() {   
    switchTrigger = 6; 
    switchHeight = 6;
    switchWidth = 22;
    switchDepth = 11;    

    difference() {
        cube(size=[switchDepth,switchWidth, floorThickness]);    
        translate([centerSide+1, center,1.5]) {
            mountingHole();
        }
        translate([center, switchWidth-centerSide,1.5]) {
            mountingHole();
        }
    }
    
    translate([switchDepth, 0, floorThickness]){
        cube(size=[switchHeight, switchWidth, switchHeight]); 
    }
    
}


module mountingHole() {
    cylinder(h = 4.02, r1 = holesSize/2 - 0.05, r2 = holesSize/2 - 0.05, center = false);
}