data {
  int<lower=1> N;
  real x[N];
  real<lower=0> alpha;
  real<lower=0> rho;
  real<lower=0> sigma;
}
transformed data {
  matrix[N, N] K = cov_exp_quad(x, alpha, rho);
  matrix[N, N] L;
  vector[N] mu = rep_vector(0, N);
  for (n in 1:N)
    K[n, n] = K[n, n] + sigma^2;
  L = cholesky_decompose(K);
}
// this should not be necessary when fixed_param option is set,
// but "The fixed_param sampler doesn't work in PyStan v2.9.0."
parameters {  real<lower=0, upper=1> theta; }
generated quantities {
  vector[N] y;
  vector[N] eta;
  for (n in 1:N)
    eta[n] = normal_rng(0, 1);
  y = mu + L*eta;
}
