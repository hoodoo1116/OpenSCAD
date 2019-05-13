$fn=50;
module attachment() {
    translate([0,0,52]) {
        rotate(a=45, v=[1,1,0]){
            difference() {
                cylinder(d1=35,h=33,d2=35, center=true);
                cylinder(d1=30,h=33,d2=30, center=true);
            }
        }
    }
}

attachment();

polygon(3,10, center=true);