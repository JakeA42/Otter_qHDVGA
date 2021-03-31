# Otter qHD VGA
This is a memory-mapped 960 x 540 VGA driver for Cal Poly's Otter CPU (although it should work in other systems as well).


## Usage
The vram is laid out in a grid 64 words wide by 540 lines tall. The last 4 words of each line are reserved to simplify addressing and are not displayed. Each 32-bit word corresponds to 16 2-bit pixels, allowing for 4 colors per pixel.

### Example
Storing the number `0b11010000101101000010110111111111` (`0xd0b42dff`) to a word in the vram results in the following pattern on the screen at that location. Note that the MSB gets mapped to the right and the LSB gets mapped to the left.

&#9617;&#9617;&#9617;&#9617;&#9618;&#9617;&#9619;&#9608;&#9608;&#9618;&#9617;&#9619;&#9608;&#9608;&#9618;&#9617;

<table>
    <tr>
		<td><b>Bit</b></td>
        <td>0</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td>31</td>
    </tr>
	<tr>
		<td><b>Value</b></td>
        <td>11</td>
        <td>11</td>
        <td>11</td>
        <td>11</td>
        <td>10</td>
        <td>11</td>
        <td>01</td>
        <td>00</td>
        <td>00</td>
        <td>10</td>
        <td>11</td>
        <td>01</td>
        <td>00</td>
        <td>00</td>
        <td>10</td>
        <td>11</td>
    </tr>
	<tr>
		<td><b>Pixel</b></td>
        <td>&#9617;</td>
        <td>&#9617;</td>
        <td>&#9617;</td>
        <td>&#9617;</td>
        <td>&#9618;</td>
        <td>&#9617;</td>
        <td>&#9619;</td>
        <td>&#9608;</td>
        <td>&#9608;</td>
        <td>&#9618;</td>
        <td>&#9617;</td>
        <td>&#9619;</td>
        <td>&#9608;</td>
        <td>&#9608;</td>
        <td>&#9618;</td>
        <td>&#9617;</td>
    </tr>
</table>

&#9608; = black, &#9619; = dark gray, &#9618; = light gray, &#9617; = white

### Layout & Addressing
The x and y address ports are intended to be connected to the IOBUS_ADDR line such that each vram address is arranged sequentially from the otter's perspective. (See the example wrapper file for connection specifics)

By default, the vram starts at address `0xfff00000` (top left on the screen) and ends at `0xfff08700` (bottom right, in the blank area).


## Installation

1. Download or clone the repository
2. In your OTTER project, go to Add sources > Add design sources > Add directories
3. Find the downloaded Otter_qHDVGA folder and choose /vga_sources/vga
4. Press Finish to complete the import
5. See the example wrapper file to connect the VGA to the OTTER.

## Tips
ulyulyuly