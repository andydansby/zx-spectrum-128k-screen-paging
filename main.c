#include <arch/zx.h>
#include <input.h>

#include "compress.h"
#include "ram6.h"

extern unsigned char screen1[];
extern unsigned char screen2[];

extern void blackout(void) __preserves_regs(a);
extern void bank(unsigned char ramBank) __preserves_regs(d,e,h,l) __z88dk_fastcall;
//extern void switchScreen(void) __preserves_regs(d,e,h,l);


void main(void)
{
	//in_pause(0);
	
   blackout();
   zx_border(0);
   
   while (1)
   {
      unpack((unsigned int)screen1, 16384);
      in_pause(500);  // in milliseconds
      
      unpack((unsigned int)screen2, 16384);
      in_pause(500);
      
      // bank 6
      
      bank(6);
      
      blackout1();
      
      unpack((unsigned int)screen3, 16384);
      in_pause(500);  // in milliseconds
      
      unpack((unsigned int)screen4, 16384);
      in_pause(500);
      
      unpack((unsigned int)screen5, 16384);
      in_pause(500);  // in milliseconds
      
      unpack((unsigned int)screen6, 16384);
      in_pause(500);
      
      bank(0);
   }
}
