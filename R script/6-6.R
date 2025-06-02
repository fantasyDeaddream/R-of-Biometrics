#例6-6
# 输入数据
data <- matrix(c(67,9,10,5,32,23,20,4,10,11,23,5), nrow = 3, byrow = TRUE,
               dimnames = list(c("11-30", "31-50","50以上"), c("治愈", "显效","好转","无效")))
alpha=0.99
print(data)
df=6
# 卡方检验
chi_test <- chisq.test(data,correct=TRUE,rescale.p = TRUE)
fisher_test <- fisher.test(data,conf.level = alpha,simulate.p.value=TRUE,B=10000,alternative = "two.sided",conf.int = TRUE)
# 输出结果
print(chi_test)
print(fisher_test)
#检验结果判别
if(chi_test$p.value>1-alpha)
{
  print("接受H0，拒绝H1")
  
  print("样本不存在相关性")
}else
{
  print("拒绝H0，接受H1")
  print("样本存在相关性")
}

