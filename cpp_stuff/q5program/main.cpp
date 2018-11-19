#include <iostream>
#include <string>
#include <random>
#include <limits>
#include "hill.h"

std::string sanstr(const char *org);

int main()
{
  std::random_device rd;
  std::mt19937 gen(rd());
  std::uniform_int_distribution<int> r(std::numeric_limits<int>::min(),
				       std::numeric_limits<int>::max());
  int foo[2][2] = {{r(gen) % 26,r(gen) % 26}, {r(gen) % 26,r(gen) % 26}};
  HillCipher2D hill(foo);

  while(hill.hasKey() != true)
  { for(int i = 0; i < 2; ++i)
      for(int j = 0; j < 2; ++j)
	foo[i][j] = r(gen) % 26;
    hill = HillCipher2D(foo);
    std::cout << '.';
  }
  std::cout << std::endl;

  std::cout << "matrix:" << std::endl;
  hill.printMatrix();
  std::cout << "inverse:" << std::endl;
  hill.printMatrixInverse();
  std::string message = sanstr("a sweet little bullet from a pretty blue gun");

  std::cout << message << std::endl;
  hill.encrypt(message);
  std::cout << message << std::endl;
  hill.decrypt(message);
  std::cout << message << std::endl;
}

std::string sanstr(const char *org)
{
  size_t i = 0;
  std::string rval;
  while(org[i] != '\0')
  { if((org[i] >= 65 && org[i] <= 90) ||
      (org[i] >= 97 && org[i] <= 122))
    { rval.push_back(org[i]); }

    ++i;
  }
  if(rval.length() % 2 != 0)
    rval.push_back(org[0]);
  return rval;
}