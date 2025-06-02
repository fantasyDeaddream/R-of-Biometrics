#例6.3
# 输入数据
observed <- c(315, 101,108,32)
expected_ratio <- c(9,3,3, 1)
alpha=0.95
df=3
# 卡方检验
chi_test <- chisq.test(observed, p = expected_ratio, rescale.p = TRUE)
kaFang=qchisq(alpha, df)
# 输出结果
print(chi_test)
cat("卡方real:",kaFang)
cat("理论频数:", sum(observed) * expected_ratio / sum(expected_ratio))

#检验结果判别
if(chi_test$p.value>1-alpha)
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
  names.arg = c("黄圆", "黄皱","绿圆","绿皱"),
  col = c("skyblue", "orange"),
  main = "观测频数与理论频数对比",
  legend.text = c("观测值", "理论值")
)