
#include <iostream>
#include <memory>

std::unique_ptr<uint32_t[]> eratos(uint32_t n);

int main()
{
	uint32_t len = 0;
	std::unique_ptr<uint32_t []> sieve = nullptr;
	std::cout << "Enter a number: ";
	std::cin >> len;
	sieve = eratos(len);
	if(sieve == nullptr)
	{	std::cerr << "Please enter a value >= 2" << std::endl;
		return -1;
	}

	for(uint32_t i = 0; i < len; ++i)
		if(sieve[i] != 0)
			std::cout << sieve[i] << std::endl;
}

std::unique_ptr<uint32_t[]> eratos(uint32_t n)
{
	if(n < 2)
		return nullptr;

	auto rval = std::unique_ptr<uint32_t[]>(new uint32_t[n]);

	for(uint32_t i = 0; i < n; ++i)
		rval[i] = 2 + i;

	for(uint32_t i = 0; i < n; ++i)
	{	uint32_t x = rval[i];
		if(x != 0)
		{	uint32_t j = 2;
			while(true)
			{	uint32_t next = j * x;
				//add and subtract 2 to account for the fact that
				//the array starts at value of 2 instead of 0.
				//n + 2 should account for overflow,
				//next - 2: update the correct corresponding index
				//with 0 (ie: '2' is at index 0, 2-2 = 2).
				if(next > 0 && next < n + 2)
					rval[next - 2] = 0;
				else
					break;
				++j;
			}
		}
	}
	return rval;
}
