#include <stdio.h>

/*
-------------------------------------------------------------------------
Neat solution to the Fizzbuzz problem (http://wiki.c2.com/?FizzBuzzTest)
I didn't come up with this. Original author: Anonymous(?)
-------------------------------------------------------------------------
*/
int main()
{
	char *fizzbuzz[] = {"%d\n", "fizz\n", "buzz\n", "fizzbuzz\n"};
	int i;
	for(i = 1; i <= 100; ++i)
		//i%3 -> 0-2 depending on the value of i
		//negating the result of this expression returns 1 iff i%3 == 0

		//ditto for i%5, except multiply the negated result by 2
		//this gives us a value of either 0 or 2

		//subscripting the result of these two combined expressions by fizzbuzz adds
		//the address of fizzbuzz to the result. This essentially resolves to
		//a pointer (to a 'string') at a particular index in fizzbuzz, since fizzbuzz is an array
		//of char pointers
		//printf((!(i%3)+!(i%5)*2)[fizzbuzz], i);
		printf(fizzbuzz[(!(i%3)+!(i%5)*2)], i);

	return 0;
}
