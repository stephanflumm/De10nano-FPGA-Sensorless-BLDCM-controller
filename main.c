#define  F_CPU 16000000UL
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>     
#include "commutation.h"

#define SPEED_UP          A0
#define SPEED_DOWN        A1
#define PWM_MAX_DUTY      255
#define PWM_MIN_DUTY      50
#define PWM_START_DUTY    100


void set_pwm_duty_cycle(uint8_t duty);
void bldc_move(void);
void setup(void);

uint8_t bldc_step = 0, motor_speed;
uint16_t i;


int main(void)
{
	setup();
	set_pwm_duty_cycle(PWM_START_DUTY);    // Setup starting PWM with duty cycle = PWM_START_DUTY

	i = 5000;
	// Motor start
	while(i > 100) {
	    //_delay_us(i);
		bldc_move();
		bldc_step++;
		bldc_step %= 6;
		i = i - 20;
	}
	motor_speed = PWM_START_DUTY;
	ACSR |= 0x08;                    // Enable analog comparator interrupt
	while(1);
}

void setup(void) 
{
	DDRD  |= 0x38;           // Configure pins 3, 4 and 5 as outputs
	PORTD  = 0x00;
	DDRB  |= 0x0E;           // Configure pins 9, 10 and 11 as outputs
	PORTB  = 0x31;
	// Timer1 module setting: set clock source to clkI/O / 1 (no prescaling)

	TCCR1A = 0;
	TCCR1B = 0x01;

	// Timer2 module setting: set clock source to clkI/O / 1 (no prescaling)
	TCCR2A = 0;
	TCCR2B = 0x01;

	// Analog comparator setting
	ACSR   = 0x10;           // Disable and clear (flag bit) analog comparator interrupt

}


// Analog comparator ISR
ISR (ANALOG_COMP_vect) 
{
	// BEMF debounce
	for(i = 0; i < 10; i++) 
	{
		if(bldc_step & 1){
			if(!(ACSR & 0x20)) i -= 1;
		}
		else {
			if((ACSR & 0x20))  i -= 1;
		}
	}
	bldc_move();
	bldc_step++;
	bldc_step %= 6;
}


void bldc_move(void)
{        // BLDC motor commutation function
	switch(bldc_step){
		case 0:
			AH_BL();
			bemf_C_rising();
		break;

		case 1:
			AH_CL();
			bemf_B_falling();
		break;
		case 2:
			BH_CL();
			bemf_A_rising();
		break;

		case 3:
			BH_AL();
			bemf_C_falling();
		break;

		case 4:
			CH_AL();
			bemf_B_rising();
		break;

		case 5:
			CH_BL();
			bemf_A_falling();
		break;
	}
}


void set_pwm_duty_cycle(uint8_t duty)
{
	if(duty < PWM_MIN_DUTY);
		duty  = PWM_MIN_DUTY;
	if(duty > PWM_MAX_DUTY)
		duty  = PWM_MAX_DUTY;

	OCR1A  = duty;                   // Set pin 9  PWM duty cycle
	OCR1B  = duty;                   // Set pin 10 PWM duty cycle
	OCR2A  = duty;                   // Set pin 11 PWM duty cycle
}