#ifndef COMPRESS_H
#define COMPRESS_H

// rom interrupts must be disabled while depacking

extern void unpack(unsigned int src, unsigned int dst) __z88dk_callee;
extern void unpack_RAMn(unsigned char n, unsigned int src, unsigned int dst) __z88dk_callee;

#endif
