#例4-11
#成对(paired)数据平均数比较的t检验
#样本数据1
x=c(3550,2000,3000,3950,3800,3750,3450,3050)
#样本数据2
y=c(2450,2400,1800,3200,3250,2700,2500,1750)
#置信度α
alpha=0.99
#t检验均值S
result=t.test(x, y ,
       alternative = "two.sided",
       mu = 0, paired = TRUE,
       conf.level = alpha)
print(result)
if(result$p.value>1-alpha)
{
  print("接受H0:μd=0，拒绝H1:μd≠0")
  print("两个样本无显著区别")
}else
{
  print("拒绝H0:μd=0，接受H1:μd≠0")
  print("两个样本存在显著区别")
}