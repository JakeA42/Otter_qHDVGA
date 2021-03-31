# Otter qHD VGA
This is a memory-mapped 960 x 540 VGA driver for Cal Poly's Otter CPU (although it should work in other systems as well).


## Usage
The vram is laid out in a grid 64 words wide by 540 lines tall. The last 4 words of each line are reserved to simplify addressing and are not displayed. Each 32-bit word corresponds to 16 2-bit pixels, allowing for 4 colors per pixel.

### Example
Storing the number `0b11010000101101000010110100001011` (`0xd0b42d0b`) somewhere in the vram results in the following pattern on the screen at that location.
<table>
    <tr>
		<td><b>Bit</b></td>
        <td>31</td>
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
        <td>0</td>
    </tr>
	<tr>
		<td><b>Value</b></td>
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
        <td>01</td>
        <td>00</td>
        <td>00</td>
        <td>10</td>
        <td>11</td>
    </tr>
	<tr>
		<td><b>Pixel</b></td>
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
        <td>&#9619;</td>
        <td>&#9608;</td>
        <td>&#9608;</td>
        <td>&#9618;</td>
        <td>&#9617;</td>
    </tr>
</table>
&#9608; = black, &#9619; = dark gray, &#9618; = light gray, &#9617; = white