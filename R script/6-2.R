#例6.2
# 输入数据
observed <- c(208, 81)
expected_ratio <- c(3, 1)
alpha=0.95
df=1
# 卡方检验
chi_test <- chisq.test(observed, p = expected_ratio, rescale.p = TRUE)
kaFang=qchisq(alpha, df)
# 输出结果
print(chi_test)
# 计算理论频数
expected <- sum(observed) * expected_ratio / sum(expected_ratio)

# 手动计算连续性校正后的卡方值
corrected_chi <- sum( (abs(observed - expected) - 0.5 )^2 / expected )

# 计算p值
p_value <- pchisq(corrected_chi, df, lower.tail = FALSE)

# 输出结果
cat("连续性校正后的卡方值:", corrected_chi, "\n")
cat("卡方real:",kaFang)
cat("理论频数:", sum(observed) * expected_ratio / sum(expected_ratio))

#检验结果判别
if(p_value>1-alpha)
{
  print("接受H0，拒绝H1")
  print("样本符合相应比率")
}else
{
  print("拒绝H0，接受H1")
  print("两个样本不符合相应比率")
}

# 可视化
barplot(
  rbind(observed, chi_test$expected),
  beside = TRUE,
  names.arg = c("显性", "隐性"),
  col = c("skyblue", "orange"),
  main = "观测频数与理论频数对比",
  legend.text = c("观测值", "理论值")
)