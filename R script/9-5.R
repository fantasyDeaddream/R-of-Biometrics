#例9-5
# 1. 准备数据
x <- c(2, 4, 6, 8, 10, 12, 14)
y <- c(0.30, 0.86, 1.73, 2.20, 2.47, 2.67, 2.80)
data <- data.frame(x, y)

# 2. 按“等间距”原则选取 y1, y2, y3：
n    <- length(y)
i1   <- 1                     # 第一组
i3   <- n                     # 最后一组
i2   <- floor((i1 + i3) / 2)  # 中间组
y1   <- y[i1]
y2   <- y[i2]
y3   <- y[i3]

# 3. 用三点公式计算 K
K_est <- ( y2^2 * (y1 + y3) - 2 * y1 * y2 * y3 ) / ( y2^2 - y1 * y3 )

# 4. 线性化变换： y' = ln((K - y) / y)
data$y_prime <- log((K_est - data$y) / data$y)

# 5. 线性回归 y' ~ x
lin.mod    <- lm(y_prime ~ x, data = data)
a_prime    <- coef(lin.mod)["(Intercept)"]
b_prime    <- coef(lin.mod)["x"]

# 6. 还原原始参数 a, b
a_est <- exp(a_prime)
b_est <- -b_prime

cat("估计参数：\n",
    "K =", round(K_est, 4), "\n",
    "a =", round(a_est, 4), "\n",
    "b =", round(b_est, 4), "\n")

# 7. 绘制散点和拟合曲线
plot(data$x, data$y,
     xlab = "x",
     ylab = "y",
     pch  = 19,
     main = "线性化 Logistic 拟合（K 由等间距三点公式计算）")

x.seq <- seq(min(x), max(x), length.out = 200)
y.pred <- K_est / (1 + a_est * exp(-b_est * x.seq))

lines(x.seq, y.pred, col = "red", lwd = 2)
legend("bottomright",
       legend = c("观测点", "线性化拟合曲线"),
       pch    = c(19, NA),
       lty    = c(NA, 1),
       col    = c("black", "red"),
       lwd    = c(NA, 2))
