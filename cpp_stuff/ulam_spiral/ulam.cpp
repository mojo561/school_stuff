#include <iostream>
#include <iomanip>
#include <memory>

std::unique_ptr<size_t[]> eratos(uint32_t n);

int main()
{
	uint32_t maxPrime = 0;
	uint32_t dmaxPrime = 0;
	uint32_t len = 0;
	std::unique_ptr<size_t []> sieve = nullptr;
	std::cout << "Enter a number: ";
	std::cin >> len;
	//7069 (prime) squared is as close as we can get to 50000000 (see memory limitations notes below)
	if(len > 7069)
	{	std::cerr << "Please enter a non-zero value <= 7069" << std::endl;
		return -1;
	}
	else if(len < 2)
	{	std::cerr << "Please enter a number >= 2" << std::endl;
		return -1;
	}

	sieve = eratos(len);

	for(size_t i = len - 1; i >= 0; --i)
	{	if(sieve[i] != 0)
		{	maxPrime = sieve[i];
			break;
		}
	}

	dmaxPrime = maxPrime * maxPrime; //-> limit: 7069^2 (49970761)

	//detatch managed pointer from sieve, then delete the pointer returned from
	//the release call
	delete[] sieve.release();

	uint32_t *numMatrix = new uint32_t[dmaxPrime];
	for(size_t i = 0; i < (dmaxPrime); ++i)
		numMatrix[i] = 0;

	sieve = eratos(dmaxPrime);

	size_t index = dmaxPrime - 1;
	size_t r;
	size_t c;

	//magic for-loop...
	for(size_t i = 0; index >= 0 && index < dmaxPrime; ++i)
	{	c = i;
		for(r = maxPrime - (i+1); r > i && index >= 0 && index < dmaxPrime; --r, --index)
			*(numMatrix + ((maxPrime * r) + c)) = sieve[index];

		for(c = i; c < (maxPrime - (i+1)) && index >= 0 && index < dmaxPrime; ++c, --index)
			*(numMatrix + ((maxPrime * r) + c)) = sieve[index];

		for(r = i; r < (maxPrime - (i+1)) && index >= 0 && index < dmaxPrime; ++r, --index)
			*(numMatrix + ((maxPrime * r) + c)) = sieve[index];

		for(c = maxPrime - (i+1); c > i && index >= 0 && index < dmaxPrime; --c, --index)
			*(numMatrix + ((maxPrime * r) + c)) = sieve[index];

		if(index == 0)
		{	uint32_t *nextA = (numMatrix + ((maxPrime * (r - 1)) + (c + 1)));
			uint32_t *nextB = (numMatrix + ((maxPrime * (r + 1)) + (c + 1)));
			if(*nextA == 0)
				*nextA = sieve[index];
			else if(*nextB == 0)
				*nextB = sieve[index];
			break;
		}
	}

	int width = 2;
	if(dmaxPrime >= 100)
		width = 4;
	else if(dmaxPrime >= 10)
		width = 3;

	for(size_t i = 0; i < maxPrime; ++i)
	{	for(size_t j = 0; j < maxPrime; ++j)
		{	uint32_t next = *(numMatrix + ((maxPrime*i) + j));
			if(next != 0)
				std::cout << std::setw(width) << next;
			else
				std::cout << std::setw(width) << ".";
		}
		std::cout << "\n";
	}
	delete[] numMatrix;
}

std::unique_ptr<size_t[]> eratos(uint32_t n)
{
	//memory limits: this virtual machine has 1024MB of RAM
	//(1024000000 bytes), allocating an array of n = (2^16)-1 already consumes
	//a significant portion of available memory ((2^16-1) * 8 = 524280 bytes)
	//Largest value we /could/ use is around 128000000 (assuming swap file is
	//also large enough?)
	//let's be nice to this VM and leave some space for other programs...
	//(128000000 - 50000000 should leave 78MB free)
	//another consideration: largest value to compute under this limit is
	//50000000^2 (2500000000000000), size_t can definitely store this, however
	//increasing the max value for n may introduce calculation errors due to
	//overflow... perhaps the ceiling is (18446744073709551616 / 2) - 1?
	// (9223372036854775807, assuming size_t = 64bits, then again you would
	//also need A LOT of RAM as well...)
	//largest prime number found under the current limit should be 49999991
	if(n > 50000000)
		return nullptr;
	else if(n == 0)
		return nullptr;

	std::unique_ptr<size_t[]> rval = std::unique_ptr<size_t[]>(new size_t[n]);

	rval[0] = 0; //1 ain't prime, let's cross it out
	//initialize the rest of the array
	for(size_t i = 1; i < n; ++i) //start at index 1 (start counting from 2)
		rval[i] = i + 1;

	//index 0 has already been evaluated, so... start at index 1
	for(size_t i = 1; i < n; ++i)
	{	size_t x = rval[i];
		if (x != 0)
		{	size_t j = 2;
			while(true)
			{	size_t next = (j * x) - 1;
				if(next < n)
					rval[next] = 0;
				else
					break;
				++j;
			}
		}
	}
	return rval;
}

/*
user input >> n

n = 1
largest prime: 0
0^2=0
...

n = 2
largest prime: 2
2^2=4

3 2

4 1


n = 3
largest prime: 3
3^2=9

7 6 5

8 1 4

9 2 3


n = 4
largest prime: 3
...


n = 5
largest prime: 5
5^2=25

21 20 19 18 17

22  7  6  5 16

23  8  1  4 15

24  9  2  3 14

25 10 11 12 13


n = 7
largest prime: 7
7^2=49

43 42 41 40 39 38 37

44 21 20 19 18 17 36

45 22  7  6  5 16 35

46 23  8  1  4 15 34

47 24  9  2  3 14 33

48 25 10 11 12 13 32

49 26 27 28 29 30 31
*/
