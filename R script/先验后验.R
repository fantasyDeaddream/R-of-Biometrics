#先验后验
# 加载必要包
# 如果要使用 ggplot2 绘图，请先安装： install.packages("ggplot2")
library(ggplot2)

# —— 一元回归模拟设置 —— 
set.seed(0)
n       <- 100
a_true  <- 2.0
b_true  <- 3.5
sigma   <- 1.0
sigma_b <- 2.0  # 先验标准差

# 生成数据
x       <- runif(n, 0, 10)
epsilon <- rnorm(n, mean = 0, sd = sigma)
y       <- a_true + b_true * x + epsilon

# 去中心化
x_centered <- x - mean(x)
y_centered <- y - mean(y)

# 1. 经典 OLS 估计 (在去中心化后，无截距)
b_hat <- sum(x_centered * y_centered) / sum(x_centered^2)

# 2. 贝叶斯后验 (已知 sigma 和 sigma_b)
# 后验精度 = (sum(x_c^2) / sigma^2) + (1 / sigma_b^2)
posterior_prec  <- sum(x_centered^2) / sigma^2 + 1 / sigma_b^2
posterior_var   <- 1 / posterior_prec
posterior_mean  <- (sum(x_centered * y_centered) / sigma^2) * posterior_var
posterior_sd    <- sqrt(posterior_var)

# 将一元结果整理到 data.frame
results_univariate <- data.frame(
  True_b         = b_true,
  OLS_b_hat      = b_hat,
  PosteriorMean  = posterior_mean,
  PosteriorSD    = posterior_sd
)

# 用 pipe 表格输出（Typora 支持这种表格语法）
# 如果想在 R Markdown 中渲染，可直接使用 knitr::kable()
cat("\n**一元回归结果（真实值、OLS 估计、后验均值、后验标准差）**\n\n")
cat("| True_b | OLS_b_hat | PosteriorMean | PosteriorSD |\n")
cat("|:------:|:---------:|:-------------:|:-----------:|\n")
cat(sprintf("| %.4f | %.4f | %.4f | %.4f |\n",
            results_univariate$True_b,
            results_univariate$OLS_b_hat,
            results_univariate$PosteriorMean,
            results_univariate$PosteriorSD))

# —— 多元回归模拟设置（p = 2） —— 
p          <- 2
beta_true  <- c(1.5, -2.0)
X          <- matrix(rnorm(n * p), nrow = n, ncol = p)
epsilon_m  <- rnorm(n, mean = 0, sd = sigma)
y_multi    <- X %*% beta_true + epsilon_m   # 无截距情形

# 1. 经典 OLS 估计 (无截距)
beta_hat <- solve(t(X) %*% X) %*% t(X) %*% y_multi

# 2. 贝叶斯后验（独立先验 N(0, sigma_b^2)）
prior_prec_mat     <- (1 / sigma_b^2) * diag(p)     # 先验精度矩阵
posterior_prec_mat <- (t(X) %*% X) / sigma^2 + prior_prec_mat
posterior_cov_mat  <- solve(posterior_prec_mat)
posterior_mean_vec <- posterior_cov_mat %*% (t(X) %*% y_multi) / sigma^2
posterior_sd_vec   <- sqrt(diag(posterior_cov_mat))

# 将多元结果整理到 data.frame
results_multivariate <- data.frame(
  Coefficient     = c("beta1", "beta2"),
  True            = beta_true,
  OLS_Estimate    = as.numeric(beta_hat),
  PosteriorMean   = as.numeric(posterior_mean_vec),
  PosteriorSD     = posterior_sd_vec
)

# 输出多元表格
cat("\n**多元回归结果（真实值、OLS 估计、后验均值、后验标准差）**\n\n")
cat("| Coefficient | True  | OLS_Estimate | PosteriorMean | PosteriorSD |\n")
cat("|:-----------:|:-----:|:------------:|:-------------:|:-----------:|\n")
for(i in 1:nrow(results_multivariate)) {
  cat(sprintf("| %s | %.4f | %.4f | %.4f | %.4f |\n",
              results_multivariate$Coefficient[i],
              results_multivariate$True[i],
              results_multivariate$OLS_Estimate[i],
              results_multivariate$PosteriorMean[i],
              results_multivariate$PosteriorSD[i]))
}

# —— 一元回归后验分布可视化 —— 
b_range      <- seq(b_hat - 3 * posterior_sd, b_hat + 3 * posterior_sd, length.out = 200)
posterior_df <- data.frame(
  b       = b_range,
  density = dnorm(b_range, mean = posterior_mean, sd = posterior_sd)
)

# 用 ggplot2 绘图
ggplot(posterior_df, aes(x = b, y = density)) +
  geom_line(size = 1) +
  geom_vline(xintercept = b_true, linetype = "dashed", color = "red", size = 0.8) +
  geom_vline(xintercept = b_hat, linetype = "dotted", color = "darkgreen", size = 0.8) +
  labs(
    title = "一元回归后验分布",
    x     = "b",
    y     = "密度"
  ) +
  theme_minimal(base_size = 12) +
  annotate("text", x = b_true + 0.1, y = max(posterior_df$density) * 0.9, 
           label = "True b", color = "red") +
  annotate("text", x = b_hat - 0.1, y = max(posterior_df$density) * 0.8, 
           label = "OLS b_hat", color = "darkgreen")