#ifndef COMMUTATION_H_
#define COMMUTATION_H_

//ISR functions
void bemf_A_rising(void);
void bemf_A_falling(void);
void bemf_B_rising(void);
void bemf_B_falling(void);
void bemf_C_rising(void);
void bemf_C_falling(void);

//Commutation functions
void AH_BL(void);
void AH_CL(void);
void BH_CL(void);
void BH_AL(void);
void CH_AL(void);
void CH_BL(void);

#endif /* COMMUTATION_H_ */