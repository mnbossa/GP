data {
  int<lower=1> N;
  real x[N];
  real<lower=0> alpha;
  real<lower=0> rho;
  real<lower=0> sigma;
}
transformed data {
  matrix[N, N] K = cov_exp_quad(x, alpha, rho);
  vector[N] mu = rep_vector(0, N);
  for (n in 1:N)
    K[n, n] = K[n, n] + sigma^2;
}
/*
  transformed data {
  matrix[N, N] K;
  vector[N] mu = rep_vector(0, N);
  for (i in 1:(N - 1)) {
  K[i, i] = alpha^2 + sigma^2;
  for (j in (i + 1):N) {
  K[i, j] = alpha^2 * exp(-0.5/rho^2 * square(x[i] - x[j]));
  K[j, i] = K[i, j];
  }
  }
  K[N, N] = alpha^2 + sigma^2;
  }
*/
generated quantities {
  vector[N] y;
  y = multi_normal_rng(mu, K);
}
