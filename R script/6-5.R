#例6-5
# 输入数据
data <- matrix(c(37, 49,23, 150,100,57), nrow = 2, byrow = TRUE,
               dimnames = list(c("死亡", "未死亡"), c("甲", "乙","丙")))
alpha=0.95
print(data)
df=3
# 卡方检验
chi_test <- chisq.test(data,correct=TRUE,rescale.p = TRUE)

# 输出结果
print(chi_test)

#检验结果判别
if(chi_test$p.value>1-alpha)
{
  print("接受H0，拒绝H1")
  
  print("两组样本不存在相关性")
}else
{
  print("拒绝H0，接受H1")
  print("两组样本存在相关性")
}

