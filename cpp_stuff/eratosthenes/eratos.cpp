#include <iostream>

int main()
{
	unsigned int len = 0;
	unsigned int *sieve = nullptr; //c++-11
	std::cout << "Enter a number: ";
	std::cin >> len;
	if(len == 0)
	{	std::cerr << "Please enter a value > 0" << std::endl;
		return -1;
	}
	sieve = new unsigned int[len];
	for(unsigned int i = 0; i < len; ++i)
		sieve[i] = 2 + i;

	for(unsigned int i = 0; i < len; ++i)
	{	unsigned int x = sieve[i];
		if(x != 0)
		{	unsigned int j = 2;
			while(true)
			{	unsigned int next = j * x;
				if(next > 0 && next < len + 2)
					sieve[next - 2] = 0;
				else
					break;
				++j;
			}
		}
	}

	for(unsigned int i = 0; i < len; ++i)
		if(sieve[i] != 0)
			std::cout << sieve[i] << std::endl;

	delete[] sieve;
}
