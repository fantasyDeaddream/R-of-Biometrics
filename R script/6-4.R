#例6-4
# 输入数据
data <- matrix(c(50, 250, 5, 195), nrow = 2, byrow = TRUE,
               dimnames = list(c("吸烟", "不吸烟"), c("患病", "未患病")))
alpha=0.99
print(data)
# 卡方检验
chi_test <- chisq.test(data,correct=TRUE,rescale.p = TRUE)

# 输出结果
print(chi_test)

#检验结果判别
if(chi_test$p.value>1-alpha)
{
  print("接受H0，拒绝H1")
  
  print("两组样本之间不存在相关性")
}else
{
  print("拒绝H0，接受H1")
  print("两个样本之间存在相关性")
}

