#例9-1
x <- c(399,329,247,191,145,119,90)
y <- c(0.380,0.379,0.371,0.343,0.317,0.301,0.248)
z <- x * y
data <- data.frame(x, y)
plot(data$x, data$y,
     xlab  = "玉米株重",
     ylab  = "经济系数",
     pch   = 19,
     main = "玉米株重-经济系数 散点及倒数拟合")

# 2. 用 nls 拟合 y =(a+b*x)/x
exp.mod <- nls(y ~ (a+b*x)/x,
               data  = data,
               start = list(a = 1, b = 0.1))

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


data <- data.frame(x, z)
model <- lm(z ~ x, data = data)
summary(model)
confint(model)
plot(data$x, data$z,
     xlab  = "玉米株重",
     ylab  = "经济系数",
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
  