# Eurorack potentiometer module

<img align="right" src="./PlaceholderImage.png">

## PCB design files

This board was designed using the [Upverter](https://upverter.com) web service.

The schematic, board layout and bill of materials can be viewed [here](https://upverter.com/Trebuchetindustries/eca55b8c9b4d3669/Eurorack-potentiometer-module/). Exports from Upverter are [available in a subdirectory](./Upverter%20exports).

## Mechanical

.....

## TODO

* [ ] Consider providing some way of connecting one of the outputs to the CV pins on the power connector
* [ ] Consider providing different voltage outputs (e.g. 0 to 10 volts, -5 to +5 volts)
* [ ] Consider adding silkscreen for power connector to both sides of the board
* [ ] Remove silkscreen lines from around potentiometers
* [ ] Move potentiometers to top side of board
* [ ] Document that phone connectors can be mounted on either side of the board (to allow for more space between pots and connectors)
* [ ] Move silkscreen text (board name and version number) to bottom of board ... or maybe put it on both sides
* [ ] Should the tip shunt be connected to ground? I think that is unnecessary on output connectors and actually a bad idea because it just wastes power through the 1K resistor when no cable is plugged in.
* [ ] Check names and pin numbers on the phone connectors, I think I might have swapped the tip spring and shunt terminal. Also I don't really like those names ... those are the names used in the datasheet so I should probably keep them but I'd probably prefer "tip" and "tip switch" or "tip shunt".
* [ ] Consider the alternate op-amp that I found when ordering parts on DigiKey ([497-2208-1-ND](https://www.digikey.com.au/product-detail/en/TL081CDT/497-2208-1-ND/) instead of [296-15001-1-ND](https://www.digikey.com.au/product-detail/en/TL081CDR/296-15001-1-ND/)). It looks like it has the same footprint but is a little cheaper.

## Licence

Copyright © 2017, 2018 Phil Baldwin

This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0).

You should have received a copy of the license along with this work. If not, see <https://creativecommons.org/licenses/by-nc-sa/4.0/>.
