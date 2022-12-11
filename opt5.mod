# Number of contracts

param nOIS;

# Time to maturity for contract

param tOIS;

# Set variables

param xi; # 1/365
param n; # All dates for curve
param a {0..n};

# Price deviation

param FOIS {0..nOIS};

# Parameter for deviation

param EOIS {0..nOIS};

# Cashflows for contracts

param NtOIS {0..nOIS};

# Market price for contracts
param pOIS {0..nOIS};

# Settlement dates

param T0OIS {0..nOIS};

# Maturity dates

param TNOIS {0..nOIS};

# Time between cashflows in respective contracts

param dtOIS {0..nOIS,0..tOIS};

# Dates for cashflows

param TiOIS {0..nOIS,0..tOIS};

# Variables

var f_0 {0..n};
var pi {0..n};
var zOIS {0..nOIS};
var f {t in 0..n} = f_0[t] + pi[t];

# Objective function

minimize obj:
(sum {t in 0..n-1}(a[t]*((f_0[t+1]-f_0[t])/xi)^2)*xi)/2 +
sum {i in 0..nOIS} (zOIS[i]*EOIS[i]*zOIS[i])/2 +
(sum {t in 0..n-1}(a[t]*((pi[t+1]-pi[t])/xi)^2)*xi)/2;

# Constraint for OIS

subject to price_OIS {i in 0..nOIS}:
exp(-sum {t in 0..T0OIS[i]} (f_0[t] + FOIS[i]*zOIS[i])/365) - exp(-sum {t in 0..TNOIS[i]} (f_0[t] + FOIS[i]*zOIS[i])/365)
= pOIS[i]*sum{j in 0..NtOIS[i]} dtOIS[i,j]*exp(-sum {t in 0..TiOIS[i,j]} (f_0[t] + FOIS[i]*zOIS[i])/365);