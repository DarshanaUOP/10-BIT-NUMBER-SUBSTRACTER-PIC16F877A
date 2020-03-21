# 10 BIT NUMBER SUBSTRACTER

### DESCRIPTION
This is a 10 bit number substractor for PIC16F877A. <br> 
<p>Usually PIC16F877A has 8 bit General purpous registers, and designers has implemented 8bit adders substractors and other things such as comparators. so it is possible to have 10bit substraction on the chip. but if the programmer needs to work in numbers greater than <code>0b11111111 =  2<sup>8</sup>-1 =255</code> ,programmer should deside if he choose a 16bit chip or use PIC16F877A with the pairs of 8bit registers such as the output register pair of the ADC of this PIC16F877A chip. </p> 
<p>
	I have coded a possible way for overcome that problem in this repository. 
</p>

### LINKS
* [Proteus simulation file](https://github.com/DarshanaUOP/10-BIT-NUMBER-SUBSTRACTER-PIC16F877A/raw/master/10BIT_NUMBER_SUBTRACT.pdsprj)
* [.asm file (assembly code)](https://github.com/DarshanaUOP/10-BIT-NUMBER-SUBSTRACTER-PIC16F877A/blob/master/10BITNUMBRSUBSTRACT.asm)
* [.hex file](https://github.com/DarshanaUOP/10-BIT-NUMBER-SUBSTRACTER-PIC16F877A/blob/master/dist/default/production/10_BIT_NUMBER_SUBSTRACTER.X.production.hex)
