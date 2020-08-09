# パッケージのロード
pacman::p_load(tidyverse)



# 繰り上がりのある足し算の場合には、isCarriedをTに繰り上がりのある足し算の場合には、isCarriedをTに --------------
# 1桁＋1桁の足し算
num1 <- 
  expand.grid(1:9, 1:9) %>% 
  as_tibble() %>% 
  mutate(ans = Var1 + Var2, 
         isCarried = ans >= 10)


# 2桁まで
num2 <- 
  expand.grid(str_pad(1:99, 2, pad = "0"), str_pad(1:99, 2, pad = "0")) %>% 
  as_tibble() %>% 
  mutate(ans = as.numeric(Var1) + as.numeric(Var2),
         ansOne = as.numeric(str_sub(Var1, start = -1, end = -1)) + as.numeric(str_sub(Var2, start = -1, end = -1)), 
         ansTens = as.numeric(str_sub(Var1, start = -2, end = -2)) + as.numeric(str_sub(Var2, start = -2, end = -2)), 
         isCarried = ansOne >= 10 | ansTens >= 10)

# 3桁まで
num3 <- 
  expand.grid(str_pad(1:999, 3, pad = "0"), str_pad(1:999, 3, pad = "0")) %>% 
  as_tibble() %>% 
  mutate(ans = as.numeric(Var1) + as.numeric(Var2),
         ansOne = as.numeric(str_sub(Var1, start = -1, end = -1)) + as.numeric(str_sub(Var2, start = -1, end = -1)), 
         ansTens = as.numeric(str_sub(Var1, start = -2, end = -2)) + as.numeric(str_sub(Var2, start = -2, end = -2)), 
         ansHundreds = as.numeric(str_sub(Var1, start = -3, end = -3)) + as.numeric(str_sub(Var2, start = -3, end = -3)), 
         isCarried = ansOne >= 10 | ansTens >= 10 | ansHundreds >= 10)


# 保存 ----------------------------------------------------------------------
saveRDS(num1, file = "app/data/num1.rds")
saveRDS(num2, file = "app/data/num2.rds")
saveRDS(num3, file = "app/data/num3.rds")


