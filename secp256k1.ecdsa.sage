#Simple ECDSA sage notebook (greg@xiph.org)

#Parameters for secp256k1
F = FiniteField (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F)
C = EllipticCurve ([F (0), F (7)])
G = C.lift_x(0x79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798)
N = FiniteField (C.order()) # how many points are in our curve

d = int(F.random_element()) # our secret
pd = G*d # our pubkey
e = int(N.random_element()) # our message

#sign
k = N.random_element() # our nonce
r = (int(k)*G).xy()[0]
s = (1/k)*(e+N(r)*d)

#verify
w = 1/N(s)
r == (int(w*e)*G + int(N(r)*w)*pd).xy()[0]

#mutate
s2 = N(s)*N(-1)
s2 != s
w = 1/s2
r == (int(w*e)*G + int(N(r)*w)*pd).xy()[0]  # sign flip mutant
