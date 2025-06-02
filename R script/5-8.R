x=c(148,143,138,145,142)
y=c(139,136,141,133,140)

wilcox.test(
  x,
  y,
  alternative = "greater",
  paired = FALSE,exact = TRUE, correct = TRUE,
  conf.int = FALSE, conf.level = 0.95,
  tol.root = 1e-8, digits.rank = Inf
)

