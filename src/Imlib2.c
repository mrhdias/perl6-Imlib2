/*
 * 
 * cc -o Imlib2.o -fPIC -c Imlib2.c
 * cc -shared -s -o Imlib2.so Imlib2.o
 * rm Imlib2.o
 * 
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "Imlib2.h"

#ifdef WIN32
#define DLLEXPORT __declspec(dllexport)
#else
#define DLLEXPORT extern
#endif

DLLEXPORT Imlib_Border *p6_imlib_init_border(int left, int right, int top, int bottom) {
	Imlib_Border *b = (Imlib_Border*)malloc(sizeof(Imlib_Border));
	
	b->left = left;
	b->right = right;
	b->top = top;
	b->bottom = bottom;
	
	return b;
}

DLLEXPORT void p6_imlib_put_border(Imlib_Border *b, int left, int right, int top, int bottom) {
	b->left = left;
	b->right = right;
	b->top = top;
	b->bottom = bottom;
}

DLLEXPORT int *p6_imlib_get_border(Imlib_Border *b) {
	int *array = malloc(4 * sizeof(int));
	
	array[0] = b->left;
	array[1] = b->right;
	array[2] = b->top;
	array[3] = b->bottom;
	
	return array;
}
