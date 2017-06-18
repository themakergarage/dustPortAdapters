/*  customDustPortAdapter OpenSCAD File
    Copyright (C) 2017 The Maker Garage

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    
*/

/*
    This file generates an adapter that allows a miter saw dust port to be connected with a shop-vac.  It was specifically designed for the Ryobi 12” Sliding Compound Miter Saw with Laser TSS120L and the Shop-Vac 90M300.  It may work with other saws and shop-vacs.  The dimensions listed below can be modified for use with another miter saw/shop-vac combo.  Due to the variance in printer calibration and quality, some tweaking of the parameters and/or the print may be required to be able to print the item.
*/
/* [Known Sizes] */

// Pick from one of the known tools or select custom.
tool = 65.5; // [65.5:Dewalt DWE7491 Table Saw,37.75:Ryobi TSS120L Miter Saw,64:Wen 6502 Belt Disc Sander]

// Pick which size vacuum attachments your vacuum uses
vacuum = 31.88; // [31.88:1.25" Attachments,63.5:2.5" Attachments] 

/* [Custom] */

// Enter the custom tool diameter in mm (A value other than 0 will override a known tool)
custom_tool_diameter = 0;

// Depth of the tool end on the adapter in mm
tool_depth = 20.5;

// Enter the custom vacuum nozzle diameter in mm (A value other than 0 will overide known vacuum sizes)
custom_vacuum_diameter = 0;

// Depth of the vacuum nozzle in mm
vacuum_depth = 51;

// Length of the transition in mm
transitionLength = 40;

// Wall thickness in mm
wallThickness = 2;


/* [Hidden] */
tool_diameter = custom_tool_diameter == 0 ? tool : custom_tool_diameter;
vacuum_diameter = custom_vacuum_diameter == 0 ? vacuum : custom_vacuum_diameter;

union(){
    difference(){
        cylinder(h=tool_depth, d=(tool_diameter+(2*wallThickness)));
        cylinder(h=tool_depth, d=tool_diameter);
    }
    //Better!
    translate([0, 0, (tool_depth+transitionLength)])
    difference(){
        cylinder(h=vacuum_depth, d=(vacuum_diameter+(2*wallThickness)));
        cylinder(h=vacuum_depth, d=vacuum_diameter);
    }
    translate([0, 0, tool_depth])
    difference(){
        cylinder(h=transitionLength, d1=(tool_diameter+(2*wallThickness)), d2=(vacuum_diameter+(2*wallThickness)));
        cylinder(h=transitionLength, d1=tool_diameter, d2=vacuum_diameter);
    }
}