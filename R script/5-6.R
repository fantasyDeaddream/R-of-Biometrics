library(coin)
x=c(94,88,83,92,87,95,90,90,86,84)
y=c(86,84,85,78,76,82,83,84,82,83)
x_jitter <- x + runif(length(x), -0.01, 0.01)  # 给 x 添加微小扰动
y_jitter <- y + runif(length(y), -0.01, 0.01)  # 给 y 添加微小扰动

wilcox.test(
  x_jitter, y_jitter,
  alternative = "two.sided",
  paired = TRUE,
  exact = TRUE,  # 仍然要求精确计算
  correct = TRUE
)

wilcox.test(
  x,
  y,
  alternative = "two.sided",
  paired = TRUE,exact = TRUE, correct = TRUE,
  conf.int = FALSE, conf.level = 0.95,
  tol.root = 1e-8, digits.rank = Inf
)

wilcox.test(
  x,
  y,
  alternative = "two.sided",
  paired = FALSE,exact = TRUE, correct = TRUE,
  conf.int = FALSE, conf.level = 0.95,
  tol.root = 1e-8, digits.rank = Inf
)

wilcoxsign_test(
  x ~ y,
  data = data.frame(x, y),
  alternative = "two.sided"
)