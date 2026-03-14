//
// din_rail_mount_G9(mod1)-1-20260306A.scad
//
// First version: 2026-03-06(Fri) JST / 2026-03-06(Fri) UTC
// Last update: 2026-03-08(Sun) 05:52 JST / 2026-03-07(Sat) 20:52 UTC
//


$fn = 96;

// For Windows
// STL_File = "C:/Users/hohno/Dropbox/work-in-progress/3D-modeling/OpenSCAD/SCAD/INCLUDE/din_rail_mount_G9.STL";
// For Mac
STL_File = "/Users/hohno/work-in-progress/3D-modeling/OpenSCAD/SCAD/INCLUDE/din_rail_mount_G9.STL";

Center_X = 5.8; //5.7;
Center_Z = 6.3;
Offset_Old = 9.5;
Offset_New = 12.7;

difference() {
    union(){  
        import(STL_File);    

        translate([Center_Z-Offset_Old, 0, Center_Z])
        rotate([90, 0, 0])
        cylinder(h = 8.45, d = 4, center = false);

        translate([Center_X+Offset_Old, 0, Center_Z])
        rotate([90, 0, 0])
        cylinder(h = 8.45, d = 4, center = false);
    }

    #translate([(Center_X)+Offset_New, 2, Center_Z])
    rotate([90, 0, 0])
    cylinder(h = 12, d = 3.2, center = false);

    #translate([(Center_X)-Offset_New, 2, Center_Z])
    rotate([90, 0, 0])
    cylinder(h = 12, d = 3.2, center = false);
}

// #translate([Center_X, 5, Center_Z])
// rotate([90, 0, 0])
// cylinder(h = 20, d = 1, center = false);

