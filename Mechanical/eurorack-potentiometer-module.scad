$fn = 64;

include <eurorack-common/panels.scad>
include <eurorack-common/Switchcraft_35RAPC2AV.scad>
include <eurorack-common/TTELectronics_P160KN.scad>

POT_SHAFT_RADIUS = TT_ELECTRONICS_P160KN_POT_SHAFT_RADIUS;
POT_SHAFT_HEIGHT = TT_ELECTRONICS_P160KN_POT_SHAFT_HEIGHT;

pcbHeight = 100;
pcbWidth = 25;
pcbThickness = 1.6;

yOffsetPCB = (EURORACK_PANEL_HEIGHT - pcbHeight) / 2;
xOffsetPCB = 4.3 + (EURORACK_PANEL_WIDTH_8HP - 4.3 - 7.0 - 4.4) / 2;
// ????????????????????????????/

xOffsetJack = xOffsetPCB - pcbThickness - 4.4 - 1;
xOffsetPot  = xOffsetPCB + POT_SHAFT_HEIGHT;

xPosConnJack = [ 95.25, 70.75, 46.25, 21.75 ];
xPosConnPot  = [ 83.00, 58.50, 34.00,  9.50 ];

module EurorackPotentiometerModule_PCB()
{
    color("green")
    if ($preview)
    {
        // Use Upverters' 3D model when doing a preview ...
        //scale([1, 1, pcbThickness * 2])
        translate([0, 0, pcbThickness/3])
        import("../PCB/Upverter exports/3d model.stl");
    }
    else
    {
        // ... but just use a dummy object when doing a render because
        // Upverter's 3D model makes the render fail
        cube([pcbWidth, pcbHeight, pcbThickness]);
    }
}

module EurorackPotentiometerModule_Panel_2D()
{
    difference()
    {
        EurorackPanel_8HP();

        for (idx = [0 : 3])
        {
            yOffsetJack = yOffsetPCB + xPosConnJack[idx];
            yOffsetPot  = yOffsetPCB + xPosConnPot[idx];
            
            translate([xOffsetJack, yOffsetJack]) circle(r=35RAPC2AV_JACK_RADIUS);
            translate([xOffsetPot,  yOffsetPot])  circle(r=POT_SHAFT_RADIUS);
        }
    }
}

module panelText(size, txt)
{
    text(size=size, valign="center", font="Helvetica", txt);
}

module EurorackPotentiometerModule_Panel_3D()
{
    linear_extrude(height = EURORACK_PANEL_THICKNESS)
    EurorackPotentiometerModule_Panel_2D();

    translate([0, yOffsetPCB, EURORACK_PANEL_THICKNESS])
    linear_extrude(height = EURORACK_PANEL_THICKNESS/3)
    for (idx = [0 : 3])
    {
        translate([xOffsetJack + 5, xPosConnJack[idx]])
        panelText(2.2, str("Out ", idx+1));

        translate([xOffsetPot - 12, xPosConnPot[idx]])
        panelText(2.3, str("Pot ", idx+1));
    }
}

module EurorackPotentiometerModule_Assembly()
{
    EurorackPotentiometerModule_Panel_3D();

    translate([xOffsetPCB, yOffsetPCB, 0])
    {
        translate([0, 0, -pcbWidth])
        rotate([0, 270, 0]) EurorackPotentiometerModule_PCB();

        for (idx = [0 : 3])
        {
            translate([0, xPosConnJack[idx], 0])
            rotate([0, 90, 180])
            Switchcraft35RAPC2AV();

            // TODO: Put potentiometers here
            // or fix "../Upverter export/3d model.stl"
        }
    }
}

//EurorackPotentiometerModule_PCB();
//EurorackPotentiometerModule_Panel_2D();
//EurorackPotentiometerModule_Panel_3D();
//EurorackPotentiometerModule_Assembly();
