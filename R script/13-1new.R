#例13-1new
# —— 准备数据 —— 
x1  <- c(10,9,10,13,10,10,8,10,10,10,10,8,6,8,9)
x2  <- c(23,20,22,21,22,23,23,24,20,21,23,21,23,21,22)
x3  <- c(3.6,3.6,3.7,3.7,3.6,3.5,3.3,3.4,3.4,3.4,3.9,3.5,3.2,3.7,3.6)
x4  <- c(113,106,111,109,110,103,100,114,104,110,104,109,114,113,105)
y   <- c(15.7,14.5,17.5,22.5,15.5,16.9,8.6,17.0,13.7,13.4,20.3,10.2,7.4,11.6,12.3)

data <- data.frame(x1, x2, x3, x4, y)

# —— 加载 glmnet 包 —— 
# install.packages("glmnet")  # 如未安装请取消注释
library(glmnet)

# —— 构建自变量矩阵 X 和响应变量 y —— 
X <- as.matrix(data[, c("x1", "x2", "x3", "x4")])
y <- data$y

# —— Lasso 回归交叉验证 —— 
lasso_cv <- cv.glmnet(X, y,family="gaussian",alpha = 1, standardize = TRUE)
print(lasso_cv)

# —— 最优 lambda —— 
best_lambda <- lasso_cv$lambda.min
cat("最优 lambda（使均方误差最小）：", best_lambda, "\n")

# —— 输出非零系数 —— 
lasso_coef <- coef(lasso_cv, s = "lambda.min")
print("非零系数：")
print(lasso_coef[lasso_coef != 0])

# —— 可选：计算 R² —— 
y_pred <- predict(lasso_cv, newx = X, s = "lambda.min")
rss <- sum((y - y_pred)^2)
tss <- sum((y - mean(y))^2)
rsq <- 1 - rss / tss
cat("Lasso 模型的 R²：", rsq, "\n")
fit_lasso <- glmnet(X, y,family="gaussian", alpha = 1)
plot(lasso_cv, xvar = "lambda",label = TRUE)
plot(fit_lasso, xvar = "lambda", label = TRUE)
