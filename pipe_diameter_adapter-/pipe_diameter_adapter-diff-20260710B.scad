// use </Users/hohno/work-in-progress/3D-modeling/OpenSCAD/SCAD/pipe_diameter_adapter-2-20260706A.scad>
use <Users/hohno/work-in-progress/3D-modeling/OpenSCAD/SCAD/pipe_diameter_adapter-3-20260710A.scad>

stl_file = "/Users/hohno/work-in-progress/3D-modeling/OpenSCAD/SCAD/pipe_diameter_adapter-2-20260706A.stl";

module current_model() {
    pipe_diameter_adapter();
}

module imported_stl() {
    import(stl_file, convexity = 10);
}

color("red")
difference() {
    current_model();
    imported_stl();
}

*color("blue")
difference() {
    imported_stl();
    current_model();
}

*current_model();
*imported_stl();