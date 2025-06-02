# 例12-1
x1  <- c(2.80, 3.03, 3.17, 2.93, 2.42, 1.63, 2.90, 2.72)
x2  <- c(1.9, 4.6, 1.6, 7.8, 2.2, 5.2, 2.0, 1.4)
x3  <- c(32, 38, 18, 38, 27, 33, 29, 25)
y   <- c(2.56, 2.33, 3.35, 1.56, 2.25, 1.00, 3.10, 2.48)

data <- data.frame(x1, x2, x3, y)
print(data)

# —— 多元线性回归 y ~ x1 + x2 + x3 —— 
model_full <- lm(y ~ x1 + x2 + x3, data = data)
model_x3less <- lm(y ~ x1 + x2 , data = data)
model_x3x2less <- lm(y ~ x1 , data = data)
model_x3x1less <- lm(y ~ x2 , data = data)
anova(model_full)   
# —— 输出常规模型结果 —— 

summary(model_full)    # 系数估计、t 值、p 值等
confint(model_full)    # 斜率和截距的 95% 置信区间

# —— 方法一：构造仅含截距的“空模型”，再与“全模型”做嵌套比较 —— 
model_null <- lm(y ~ 1, data = data)    # 仅截距的空模型
anova(model_null, model_full)           # 将 x1,x2,x3 三个一起看作“回归”来源
AIC(model_full)
BIC(model_full)
library(ppcor)
pcor_all <- pcor(data)
# 查看偏相关系数矩阵
pcor_all$estimate

# 查看对应的 p 值矩阵
pcor_all$p.value

summary(model_x3less)    # 系数估计、t 值、p 值等
AIC(model_x3less)
BIC(model_x3less)
summary(model_x3x2less)    # 系数估计、t 值、p 值等
AIC(model_x3x2less)
BIC(model_x3x2less)
summary(model_x3x1less)    # 系数估计、t 值、p 值等
AIC(model_x3x1less)
BIC(model_x3x1less)
# 加载必要的包
library(ggplot2)

# 计算预测值
data$predicted <- predict(model_multi)

# 绘制散点图
ggplot(data, aes(x = predicted, y = y)) +
  geom_point(color = "blue", size = 3) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "red") +
  labs(title = "预测值与实际值的比较",
       x = "预测值",
       y = "实际值") +
  theme_minimal()

