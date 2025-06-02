# 例 8.1 数据及模型
x <- c(11.8,14.7,15.6,16.8,17.1,18.8,19.5,20.4)
y <- c(30.1,17.3,16.7,13.6,11.9,10.7,8.3,6.7)
data <- data.frame(x, y)

model <- lm(y ~ x, data = data)

# 打印模型摘要和置信区间、ANOVA
summary(model)
confint(model)          # 斜率和截距的 95% 置信区间
anova_res <- anova(model)
print(anova_res)
r <- cor.test(data$x, data$y,conf.level = 0.95)
print(r)

# 1. 绘制散点和空白画布
plot(data$x, data$y,
     main  = "带 95% 置信区间的线性回归",
     xlab  = "平均温度",
     ylab  = "历期天数",
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

# 6. 残差-拟合值诊断图
plot(model, which = 1,
     main = "残差-拟合值诊断图")


# 创建新数据框用于预测
new_data <- data.frame(x = c(15))

# 进行预测，返回预测值及置信区间
predict(model, newdata = new_data, interval = "confidence",level = 0.95)
predict(model, newdata = new_data, interval = "prediction",level = 0.95)
