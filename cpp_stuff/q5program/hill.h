#ifndef _HILL_CIPHER_H
#define _HILL_CIPHER_H
#include <string>
class HillCipher2D
{
public:
  HillCipher2D(int mat[2][2], int mod = 26);
  void printMatrix(void);
  void printMatrixInverse(void);
  void encrypt(std::string &msg);
  void decrypt(std::string &msg);
  bool hasKey();
private:
  bool isInversable;
  int mod;
  int matorg[2][2];
  int matinv[2][2];
  int gcd(int val);
  int findInverse(int val);
  int findDeterminant(int mat[2][2]);
  void adj(int mat[][2]);
  void multiplyMatByScalarMod(int mat[][2], int value);
  void multiplyMatByVectorMod(int mat[2][2], int vector[]);
};
#endif