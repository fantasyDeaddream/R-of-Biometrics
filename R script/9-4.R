#例9-4
x <- c(12,15,19,25,32,35,38,41,46,49,58)
y <- c(0.17430,0.11080,0.06340,0.05310,0.04155,0.04080,0.04020,0.03998,0.03762,0.03538,0.03533)

data <- data.frame(x, y)

# 1. 画散点图
plot(data$x, data$y,
     xlab = "温度",
     ylab = "产卵数",
     pch  = 19,
     main = "温度-产卵数 散点及指数拟合")

# 2. 用 nls 拟合 y = a+b*log10(x)
exp.mod <- nls(y ~ a*x^b,
               data  = data,
               start = list(a = 1.4, b = -0.96))
summary(exp.mod)
# 查看拟合系数
coef(exp.mod)
#     a           b 
#（比如 a=1.23, b=0.20，具体值根据你的数据而定）

# 3. 在散点图上加上拟合曲线
#  3.1 生成细分的 x 供预测之用
x.seq <- seq(min(x), max(x), length.out = 200)
#  3.2 用拟合模型预测对应的 y 值
y.pred <- predict(exp.mod, newdata = data.frame(x = x.seq))
#  3.3 绘制曲线
lines(x.seq, y.pred, col = "red", lwd = 2)

x <- log10(x)
y<-log10(y)
data <- data.frame(x, y)
model <- lm(y ~ x, data = data)
summary(model)
confint(model)
plot(data$x, data$y,
     xlab  = "膜内最高温度",
     ylab  = "室外最高温度",
     pch   = 19)
# 2. 生成平滑的 x 序列，计算预测值和置信区间
x.seq <- seq(min(data$x), max(data$x), length.out = 100)
pred  <- predict(model,
                 newdata   = data.frame(x = x.seq),
                 interval  = "confidence",
                 level     = 0.95)

# 3. 绘制置信带（半透明多边形）
polygon(
  x      = c(x.seq, rev(x.seq)),
  y      = c(pred[,"lwr"], rev(pred[,"upr"])),
  col    = rgb(0, 0, 1, 0.2),
  border = NA
)

# 4. 添加回归拟合线
lines(x.seq, pred[,"fit"], col = "blue", lwd = 2, lty = 1)

# 5. 添加图例（包含置信区间说明）
legend("topright",
       legend = c("回归线", "95% 置信区间"),
       col    = c("blue", rgb(0, 0, 1, 0.2)),
       lty    = c(1, NA),
       lwd    = c(2, NA),
       pch    = c(NA, 15),
       pt.cex = c(NA, 2),
       pt.bg  = c(NA, rgb(0, 0, 1, 0.2)),
       title  = "图例",
       bty    = "n"
)
print(model$coefficients)
coef(model)

modelaov <- aov(y ~ x, data = data) 

# 7. 输出方差分析表
print(summary(modelaov))