
x=c(22,24,25,27,32,35,37,39,43,45)
x_jitter <- x + runif(length(x), -0.01, 0.01)  # 给 x 添加微小扰动


wilcox.test(
  x_jitter, y_jitter=NULL,
  alternative = "greater",
  mu=28,
  paired = FALSE,
  exact = TRUE,  # 仍然要求精确计算
  correct = TRUE
)

wilcox.test(
  x,
  y=NULL,
  alternative = "greater",
  mu=28,
  paired = FALSE,exact = TRUE, correct = TRUE,
  conf.int = FALSE, conf.level = 0.95,
  tol.root = 1e-4, digits.rank = Inf
)
