x <- c(49,50,54,58) 
y <- c(36,41,38,42)     
z <- c(33,34,31,35) 
kruskal.test(list(x, y, z))
## Equivalently,
x <- c(x, y, z)
g <- factor(rep(1:3, c(4,4,4)),
            labels = c("A",
                       "B",
                       "C"))
kruskal.test(x, g)
