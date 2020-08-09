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
  expand.grid(1:99, 1:99) %>% 
  as_tibble() %>% 
  mutate(paddedVar1 = str_pad(Var1, 2, pad = "0"),  # 0埋め(padding)した値 
         paddedVar2 = str_pad(Var2, 2, pad = "0"), 
         ans = Var1 + Var2,  # 足し算の解答
         ansOne = as.numeric(str_sub(paddedVar1, start = -1, end = -1)) + as.numeric(str_sub(paddedVar2, start = -1, end = -1)),  # 一の位の足し算解答
         ansTens = as.numeric(str_sub(paddedVar1, start = -2, end = -2)) + as.numeric(str_sub(paddedVar2, start = -2, end = -2)),  # 十の位の足し算解答
         isCarried = ansOne >= 10 | ansTens >= 10)  # 繰り上がりしているかどうかのフラグ（TRUE: 繰り上がりあり）


# 3桁まで
num3 <- 
  expand.grid(1:999, 1:999) %>% 
  as_tibble() %>% 
  mutate(paddedVar1 = str_pad(Var1, 3, pad = "0"),   # 0埋め(padding)した値 
         paddedVar2 = str_pad(Var2, 3, pad = "0"), 
         ans = Var1 + Var2,  # 足し算の解答
         ansOne = as.numeric(str_sub(paddedVar1, start = -1, end = -1)) + as.numeric(str_sub(paddedVar2, start = -1, end = -1)),  # 一の位の足し算解答
         ansTens = as.numeric(str_sub(paddedVar1, start = -2, end = -2)) + as.numeric(str_sub(paddedVar2, start = -2, end = -2)),  # 十の位の足し算解答
         ansHundreds = as.numeric(str_sub(paddedVar1, start = -3, end = -3)) + as.numeric(str_sub(paddedVar2, start = -3, end = -3)),  # 百の位の足し算解答
         isCarried = ansOne >= 10 | ansTens >= 10 | ansHundreds >= 10)  # 繰り上がりしているかどうかのフラグ（TRUE: 繰り上がりあり）


# 保存 ----------------------------------------------------------------------
saveRDS(num1, file = "app/data/num1.rds")
saveRDS(num2, file = "app/data/num2.rds")
saveRDS(num3, file = "app/data/num3.rds")


