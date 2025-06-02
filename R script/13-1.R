# 例13-1
x1  <- c(10,9,10,13,10,10,8,10,10,10,10,8,6,8,9)
x2  <- c(23,20,22,21,22,23,23,24,20,21,23,21,23,21,22)
x3  <- c(3.6,3.6,3.7,3.7,3.6,3.5,3.3,3.4,3.4,3.4,3.9,3.5,3.2,3.7,3.6)
x4 <- c(113,106,111,109,110,103,100,114,104,110,104,109,114,113,105)
y   <- c(15.7,14.5,17.5,22.5,15.5,16.9,8.6,17.0,13.7,13.4,20.3,10.2,7.4,11.6,12.3)

data <- data.frame(x1, x2, x3, x4,y)
print(data)

# —— 多元线性回归 y ~ x1 + x2 + x3 —— 
model_full <- lm(y ~ x1 + x2 + x3+x4, data = data)

anova(model_full)   
# —— 输出常规模型结果 —— 

summary(model_full)    # 系数估计、t 值、p 值等
confint(model_full)    # 斜率和截距的 95% 置信区间
model_less_backward1<-step(model_full,scope = list(lower = ~ 1,upper = ~ x1 + x2 + x3 + x4),direction="backward",trace=2,steps = 1000,k = 2)  
model_less_backward2<-step(model_full,scope = list(lower = ~ 1,upper = ~ x1 + x2 + x3 + x4),direction="backward",trace=2,steps = 1000,k = log(nrow(data)))  
model_less_both<-step(model_full,scope = list(lower = ~ 1,upper = ~ x1 + x2 + x3 + x4),direction="both",trace=2,steps = 1000,k = 2)  
#anova(model_less)
# —— 方法一：构造仅含截距的“空模型”，再与“全模型”做嵌套比较 —— 
model_null <- lm(y ~ 1, data = data)    # 仅截距的空模型
model_less_forward<-step(model_null,scope = list(lower = ~ 1,upper = ~ x1 + x2 + x3 + x4),direction="forward",trace=2,steps = 1000,k = 2)
anova(model_null, model_full)           # 将 x1,x2,x3,x4 三个一起看作“回归”来源
AIC(model_full)
BIC(model_full)
library(ppcor)
pcor_all <- pcor(data)
# 查看偏相关系数矩阵
pcor_all$estimate


# 加载必要的包
library(ggplot2)

# 计算预测值
data$predicted <- predict(model_full)

# 绘制散点图
ggplot(data, aes(x = predicted, y = y)) +
  geom_point(color = "blue", size = 3) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "red") +
  labs(title = "预测值与实际值的比较",
       x = "预测值",
       y = "实际值") +
  theme_minimal()


library(lm.beta)
fit.raw <- lm(y ~ x1 + x2 + x3, data = data)
fit.beta <- lm.beta(fit.raw)
summary(fit.beta)
# 2. 标准化（scale() 默认按每列处理：减均值、除以总体标准差）
data.std <- as.data.frame(scale(data))

# 3. 对标准化后的 y 做多元回归
fit.std <- lm(y ~ x1 + x2 + x3 , data = data.std)
summary(fit.std)
# 4. 提取标准化回归系数（去掉 intercept）
coef.std <- summary(fit.std)$coefficients
print(coef.std)
beta1 <- coef.std["x1","Estimate"]
beta2 <- coef.std["x2","Estimate"]
beta3 <- coef.std["x3","Estimate"]

# 3. 计算三个自变量之间的相关系数
r12 <- cor(data$x1, data$x2)
print(r12)
r13 <- cor(data$x1, data$x3)
print(r13)
r23 <- cor(data$x2, data$x3)
print(r23)

# 4. 计算自变量与因变量的零阶相关
r_yx1 <- cor(data$x1, data$y)
print(r_yx1)
r_yx2 <- cor(data$x2, data$y)
print(r_yx2)
r_yx3 <- cor(data$x3, data$y)
print(r_yx3)

# 5. 计算六个间接通径系数
#    例如 x1 通过 x2 的间接通径： r12 * β2
indirect_x1_via_x2 <- r12 * beta2
print(indirect_x1_via_x2)
indirect_x1_via_x3 <- r13 * beta3
print(indirect_x1_via_x3)
indirect_x2_via_x1 <- r12 * beta1
print(indirect_x2_via_x1)
indirect_x2_via_x3 <- r23 * beta3
print(indirect_x2_via_x3)
indirect_x3_via_x1 <- r13 * beta1
print(indirect_x3_via_x1)
indirect_x3_via_x2 <- r23 * beta2
print(indirect_x3_via_x2)

