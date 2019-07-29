#include <avr/io.h>
#include "commutation.h"

void bemf_A_rising(void)
{
	ADCSRB = (0 << ACME);    // Select AIN1 as comparator negative input
	ACSR |= 0x03;            // Set interrupt on rising edge
}

void bemf_A_falling(void)
{
	ADCSRB = (0 << ACME);    // Select AIN1 as comparator negative input
	ACSR &= ~0x01;           // Set interrupt on falling edge
}

void bemf_B_rising(void)
{
	ADCSRA = (0 << ADEN);   // Disable the ADC module
	ADCSRB = (1 << ACME);
	ADMUX = 2;              // Select analog channel 2 as comparator negative input
	ACSR |= 0x03;
}

void bemf_B_falling(void)
{
	ADCSRA = (0 << ADEN);   // Disable the ADC module
	ADCSRB = (1 << ACME);
	ADMUX = 2;              // Select analog channel 2 as comparator negative input
	ACSR &= ~0x01;
}

void bemf_C_rising(void)
{
	ADCSRA = (0 << ADEN);   // Disable the ADC module
	ADCSRB = (1 << ACME);
	ADMUX = 3;              // Select analog channel 3 as comparator negative input
	ACSR |= 0x03;
}

void bemf_C_falling(void)
{
	ADCSRA = (0 << ADEN);   // Disable the ADC module
	ADCSRB = (1 << ACME);
	ADMUX = 3;              // Select analog channel 3 as comparator negative input
	ACSR &= ~0x01;
}


void AH_BL(void)
{
	PORTB  =  0x04;
	PORTD &= ~0x18;
	PORTD |=  0x20;
	TCCR1A =  0;            // Turn pin 11 (OC2A) PWM ON (pin 9 & pin 10 OFF)
	TCCR2A =  0x81;         //
}

void AH_CL(void)
{
	PORTB  =  0x02;
	PORTD &= ~0x18;
	PORTD |=  0x20;
	TCCR1A =  0;            // Turn pin 11 (OC2A) PWM ON (pin 9 & pin 10 OFF)
	TCCR2A =  0x81;         //
}

void BH_CL(void)
{
	PORTB  =  0x02;
	PORTD &= ~0x28;
	PORTD |=  0x10;
	TCCR2A =  0;            // Turn pin 10 (OC1B) PWM ON (pin 9 & pin 11 OFF)
	TCCR1A =  0x21;         //
}

void BH_AL(void)
{
	PORTB  =  0x08;
	PORTD &= ~0x28;
	PORTD |=  0x10;
	TCCR2A =  0;            // Turn pin 10 (OC1B) PWM ON (pin 9 & pin 11 OFF)
	TCCR1A =  0x21;         //
}

void CH_AL(void)
{
	PORTB  =  0x08;
	PORTD &= ~0x30;
	PORTD |=  0x08;
	TCCR2A =  0;            // Turn pin 9 (OC1A) PWM ON (pin 10 & pin 11 OFF)
	TCCR1A =  0x81;         //
}

void CH_BL(void)
{
	PORTB  =  0x04;
	PORTD &= ~0x30;
	PORTD |=  0x08;
	TCCR2A =  0;            // Turn pin 9 (OC1A) PWM ON (pin 10 & pin 11 OFF)
	TCCR1A =  0x81;         //
}