/*
 * This file is part of the MSP430 stand alone example.
 *
 * Copyright (C) 2012 Stefan Wendler <sw@kaltpost.de>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include  <msp430.h>
#include <legacymsp430.h>

interrupt(PORT1_VECTOR) PORT1_ISR(void)
{
    P1IFG &= ~BIT3;                 		
	P1OUT ^= BIT0; 
}

int main(void)
{
	WDTCTL = WDTPW + WDTHOLD;              
	P1DIR = BIT0 + BIT6; 				
	P1OUT = 0; 

    P1IES |=  BIT3;
    P1IFG &= ~BIT3;
    P1IE  |=  BIT3;

	__bis_SR_register(GIE);

	for (;;)
	{
		volatile unsigned long i;
		P1OUT ^= BIT0 + BIT6; 
		i = 49999; 

		do (i--);
		while (i != 0);
	}
}
