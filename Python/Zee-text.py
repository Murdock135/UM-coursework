# p = q = r = 10
# a = 1.0/3.0*(p+q+r)
# print("Average of three variables is", a)
# print("Average of three variables is %.2f" % a)
# print("Average of three variables is %d" % a)

a = 10
b = 4
c = a & b
d = a ^ b
e = a | b
print('The result of 10 and 4 operation is', c)
print('The result of 10 exclusive and 4 operation is', d)
print('The result of 10 or 4 operation is', e)
g = a << 2
print('Left shifting - Multiplying 10 by 4 becomes:', g)
h = a >> 1
print('Right shifting - Dividing 10 by 2 becomes:', h)


a = 3.0 + 1.2j
b = -2.0 - 9.0j
print('The two complex numbers are', a, 'and', b)
c = a+b
print('The addition of two complex numbers is:', c)
print('The addition of two real numbers is:', a.real+b.real)
print('The addition of two imaginary number is:', a.imag+b.imag)
