//
// pipe_diameter_adapter-2-20260706A.scad
// 

// Last update: 2026-07-06(Mon) 13:18 JST / 2026-07-06(Mon) 04:18 UTC
// Last update: 2026-07-10(Fri) 10:02 JST / 2026-07-10(Fri) 01:02 UTC (introducing module)

module pipe_diameter_adapter() {
    // Parameters
    outer_inner_diameter  = 146.0;
    outer_outer_diameter  = 152.0;
    outer_height          = 45.0;

    lid_thickness         = 3.0;

    center_inner_diameter = 65.0;
    center_outer_diameter = 70.0;
    center_height         = 65.0;

    window_width          = 12.5;
    window_depth          = 10.0;
    window_height         = 10.0;
    window_bottom         = 22.0;

    reinforce_radius      = 4.0;

    cut_margin            = 1.0;

    $fn = 180;

    // Modules
    module torus(major_radius, minor_radius) {
        rotate_extrude()
        translate([major_radius, 0, 0])
        circle(r = minor_radius);
    }

    // Model
    difference() {
        union() {
            cylinder(d = outer_outer_diameter, h = outer_height);

            translate([0, 0, outer_height - lid_thickness])
            cylinder(d = outer_outer_diameter, h = lid_thickness);

            translate([0, 0, outer_height - lid_thickness])
            cylinder(d = center_outer_diameter,
                     h = center_height + lid_thickness);

            // Reinforcement around center cylinder base
            translate([0, 0, outer_height - lid_thickness])
            torus(center_outer_diameter / 2, reinforce_radius);

            // Reinforcement inside outer cylinder / lid joint
            translate([0, 0, outer_height - lid_thickness])
            torus(outer_inner_diameter / 2, reinforce_radius);
        }

        translate([0, 0, -cut_margin])
        cylinder(d = outer_inner_diameter,
                 h = outer_height - lid_thickness + cut_margin);

        translate([0, 0, outer_height - lid_thickness - cut_margin])
        cylinder(d = center_inner_diameter,
                 h = center_height + lid_thickness + 2 * cut_margin);

        for (angle = [0:120:240]) {
            rotate([0, 0, angle])
            translate([outer_outer_diameter / 2 - window_depth / 2,
                       0,
                       window_bottom + window_height / 2])
            cube([window_depth, window_width, window_height],
                 center = true);
        }
    }
}

pipe_diameter_adapter();