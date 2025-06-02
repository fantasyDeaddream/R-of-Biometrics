#例6-7
# 输入数据
data <- matrix(c(4,1,6,28), nrow = 2, byrow = TRUE,
               dimnames = list(c("死亡", "存活"), c("CMT", "ECMO")))
alpha=0.95
print(data)
# Fisher和卡方检验
fisher_test <- fisher.test(data,conf.level = alpha)
chi_test <- chisq.test(data,correct=TRUE,rescale.p = TRUE)
# 输出结果
print(fisher_test)
print(chi_test)
#检验结果判别
if(fisher_test$p.value>1-alpha)
{
  print("接受H0，拒绝H1")
  
  print("样本不存在相关性")
}else
{
  print("拒绝H0，接受H1")
  print("样本存在相关性")
}

