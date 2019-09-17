$fn = 64;

include <eurorack-common/panels.scad>
include <eurorack-common/Switchcraft_35RAPC2AV.scad>

pcbHeight = 7.5 + 10 + 15 + 10 + 15 + 10 + 15 + 10 + 7.5;
pcbWidth = 15;
pcbThickness = 1.6;

yOffsetPCB = (EURORACK_PANEL_HEIGHT - pcbHeight) / 2;
xOffsetPCB = 4.3 + (EURORACK_PANEL_WIDTH_4HP - 4.3 - 7.0 - 4.4) / 2;

xPosConn = [ 5, 15, 25, 35, 45, 55, 65, 75, 85, 95 ];

module EurorackBufferedMultModule_PCB()
{
    color("green")
    if ($preview)
    {
        // Use Upverters' 3D model when doing a preview ...
        scale([1, 1, pcbThickness * 2])
        translate([0, 0, pcbThickness/3])
        import("../Upverter exports/3d model.stl");
    }
    else
    {
        // ... but just use a dummy object when doing a render because
        // Upverter's 3D model makes the render fail
        cube([pcbWidth, pcbHeight, pcbThickness]);
    }
}

module EurorackBufferedMultModule_Panel_2D()
{
    xOffset = xOffsetPCB + 35RAPC2AV_JACK_RADIUS + 4.4 - 1;
    yOffset = yOffsetPCB;

    difference()
    {
        EurorackPanel_4HP();

        translate([xOffset, yOffset, 0])
        for (idx = [0 : 9])
        {
            translate([0, xPosConn[idx], 0]) circle(r=35RAPC2AV_JACK_RADIUS);
        }
    }
}

module panelText(size, txt)
{
    text(size=size, valign="center", font="Helvetica", txt);
}

module EurorackBufferedMultModule_Panel_3D()
{
    linear_extrude(height = EURORACK_PANEL_THICKNESS)
    EurorackBufferedMultModule_Panel_2D();

    translate([0, yOffsetPCB, EURORACK_PANEL_THICKNESS])
    linear_extrude(height = EURORACK_PANEL_THICKNESS/3)
    {
        translate([2, xPosConn[0]]) panelText(2.3, "Out8");
        translate([2, xPosConn[1]]) panelText(2.3, "Out7");
        translate([2, xPosConn[2]]) panelText(2.3, "Out6");
        translate([2, xPosConn[3]]) panelText(2.3, "Out5");
        translate([2, xPosConn[4]]) panelText(2.3, "In2");
        translate([2, xPosConn[5]]) panelText(2.3, "Out4");
        translate([2, xPosConn[6]]) panelText(2.3, "Out3");
        translate([2, xPosConn[7]]) panelText(2.3, "Out2");
        translate([2, xPosConn[8]]) panelText(2.3, "Out1");
        translate([2, xPosConn[9]]) panelText(2.3, "In1");
    }
}

module EurorackBufferedMultModule_Assembly()
{
    EurorackBufferedMultModule_Panel_3D();

    translate([xOffsetPCB, yOffsetPCB, 0])
    {
        translate([-pcbThickness, 0, 0])
        rotate([0, 90, 0]) EurorackBufferedMultModule_PCB();

        for (idx = [0 : 9])
        {
            translate([0, xPosConn[idx], 0])
            rotate([0, 90, 0])
            Switchcraft35RAPC2AV();
        }
    }
}

//EurorackBufferedMultModule_PCB();
//EurorackBufferedMultModule_Panel_2D();
//EurorackBufferedMultModule_Panel_3D();
EurorackBufferedMultModule_Assembly();
