# —— 0. 加载包 & 设置对比方式 —— 
# 安装（如有必要）：install.packages(c("car"))
library(car)
# 显式指定默认对比（Treatment 对比）
options(contrasts = c("contr.treatment", "contr.poly"))

# —— 1. 构造原始“长”表格数据 —— 
A <- factor(rep(c("A1","A2","A3"), each = 2*8))
B <- factor(rep(rep(c("x","y"), each = 8), times = 3))
value <- c(
  18,16,11,14,14,13,17,17,
  85,89,65,80,78,83,91,85,
  17,18,18,19,21,21,16,22,
  95,100,94,98,104,97,90,106,
  18,23,23,20,24,25,25,26,
  91,89,98,82,100,98,102,108
)
df <- data.frame(A, B, value)

# —— 2. 重整为“每头猪一行” —— 
df$pigID <- rep(1:8, times = 3, each = 2)
df2 <- reshape(df,
               idvar     = c("A","pigID"),
               timevar   = "B",
               direction = "wide")
names(df2)[names(df2) == "value.x"] <- "x"
names(df2)[names(df2) == "value.y"] <- "y"

# —— 3. 因子声明 —— 
# 确保 A 是三水平因子
df2$A <- factor(df2$A, levels = c("A1","A2","A3"))

# —— 4. 协方差分析（ANCOVA） —— 
# 强制在公式里用 factor(A)
anc <- aov(y ~ x + factor(A), data = df2)

cat("—— ANCOVA Type I SS ——\n")
print(summary(anc))

cat("\n—— ANCOVA Type III SS ——\n")
print(Anova(anc, type="III"))

# —— 5. 单因素方差分析（ANOVA） —— 
oneway <- aov(y ~ factor(A), data = df2)
cat("\n—— One-way ANOVA ——\n")
print(summary(oneway))
