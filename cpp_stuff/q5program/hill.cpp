#include <iostream>
#include "hill.h"

namespace
{
  void domatprint(int m[][2])
  {
    for(int i = 0; i < 2; ++i)
    { for(int j = 0; j < 2; ++j)
      { std::cout << m[i][j] << " ";
      }
      std::cout << std::endl;
    }
  }
}

HillCipher2D::HillCipher2D(int mat[2][2], int mod)
{
  for(int i = 0; i < 2; ++i)
  { for(int j = 0; j < 2; ++j)
    { matorg[i][j] = mat[i][j];
      matinv[i][j] = mat[i][j];
    }
  }
  this->mod = mod;
  
  int determinant = findDeterminant(matinv);
  int determinantInverse = findInverse(determinant);
  if(determinantInverse <= 0)
  { isInversable = false;
  }
  else
  { isInversable = true;
    adj(matinv);
    multiplyMatByScalarMod(matinv, determinantInverse);
  }
}

void HillCipher2D::printMatrix(void) { domatprint(matorg); }
void HillCipher2D::printMatrixInverse(void) { domatprint(matinv); }

void HillCipher2D::encrypt(std::string &msg)
{
  for(int i = 0; i < msg.length(); i+=2)
  {
    std::string substr = msg.substr(i, i + 2);
    int digram[2] = {substr[0] - 97, substr[1] - 97};
    multiplyMatByVectorMod(matorg, digram);
    msg[i] = digram[0] + 97;
    msg[i + 1] = digram[1] + 97;
  }
}

void HillCipher2D::decrypt(std::string &msg)
{
  for(int i = 0; i < msg.length(); i+=2)
  {
    std::string substr = msg.substr(i, i + 2);
    int digram[2] = {substr[0] - 97, substr[1] - 97};
    multiplyMatByVectorMod(matinv, digram);
    msg[i] = digram[0] + 97;
    msg[i + 1] = digram[1] + 97;
  }
}

bool HillCipher2D::hasKey() { return isInversable; }

//assume: this->mod > 0
int HillCipher2D::gcd(int val)
{
  if(val == 0 || val < 0)
    return 0;

  int t = 0;
  int y = this->mod;
  do
  { t = y;
    y = val % y;
    val = t;
  } while(y != 0);
  return val;
}

int HillCipher2D::findInverse(int val)
{
  for(int i = 1; i < this->mod; ++i)
  { //assume this->mod is composite
    //check only odd numbers if they are relatively prime
    if(i % 2 != 0)
    { int test = gcd(i);
      if(test == 1 && (i * val) % this->mod == 1)
	return i;
    }
  }
  return 0;
}

int HillCipher2D::findDeterminant(int mat[2][2])
{
  int det = (mat[0][0] * mat[1][1] - mat[0][1] * mat[1][0]) % this->mod;
  return (det < 0 ? det + this->mod : det);
}

void HillCipher2D::adj(int mat[][2])
{
  int temp = mat[0][0];
  mat[0][0] = mat[1][1];
  mat[1][1] = temp;
  mat[0][1] *= -1;
  mat[1][0] *= -1;

  for(int i = 0; i < 2; ++i)
  { for(int j = 0; j < 2; ++j)
    { mat[i][j] %= this->mod;
      if(mat[i][j] < 0)
	mat[i][j] += this->mod;
    }
  }
}

void HillCipher2D::multiplyMatByScalarMod(int mat[][2], int value)
{
  for(int i = 0; i < 2; ++i)
    for(int j = 0; j < 2; ++j)
    { mat[i][j] = (mat[i][j] * value) % this->mod;
      if(mat[i][j] < 0)
	mat[i][j] += this->mod;
    }
}

void HillCipher2D::multiplyMatByVectorMod(int mat[2][2], int vector[])
{
  int temp[2] = {0};
  for(int i = 0; i < 2; ++i)
  { for(int j = 0; j < 2; ++j)
    { temp[i] += (mat[i][j] * vector[j]);
      temp[i] = temp[i] % this->mod;
      if(temp[i] < 0)
	temp[i] += this->mod;
    }
  }
  vector[0] = temp[0];
  vector[1] = temp[1];
}