# パッケージのロード
pacman::p_load(tidyverse)



# 繰り上がりのある足し算の場合には、isCarriedをTに繰り上がりのある足し算の場合には、isCarriedをTに --------------
# 1桁＋1桁の足し算
addAns1 <- 
  expand.grid(1:9, 1:9) %>% 
  as_tibble() %>% 
  mutate(ans = Var1 + Var2, 
         isCarried = ans >= 10)


# 2桁まで
addAns2 <- 
  expand.grid(1:99, 1:99) %>% 
  as_tibble() %>% 
  mutate(paddedVar1 = str_pad(Var1, 2, pad = "0"),  # 0埋め(padding)した値 
         paddedVar2 = str_pad(Var2, 2, pad = "0"), 
         ans = Var1 + Var2,  # 足し算の解答
         ansOne = as.numeric(str_sub(paddedVar1, start = -1, end = -1)) + as.numeric(str_sub(paddedVar2, start = -1, end = -1)),  # 一の位の足し算解答
         ansTens = as.numeric(str_sub(paddedVar1, start = -2, end = -2)) + as.numeric(str_sub(paddedVar2, start = -2, end = -2)),  # 十の位の足し算解答
         isCarried = ansOne >= 10 | ansTens >= 10)  # 繰り上がりしているかどうかのフラグ（TRUE: 繰り上がりあり）


# 3桁まで
addAns3 <- 
  expand.grid(1:999, 1:999) %>% 
  as_tibble() %>% 
  mutate(paddedVar1 = str_pad(Var1, 3, pad = "0"),   # 0埋め(padding)した値 
         paddedVar2 = str_pad(Var2, 3, pad = "0"), 
         ans = Var1 + Var2,  # 足し算の解答
         ansOne = as.numeric(str_sub(paddedVar1, start = -1, end = -1)) + as.numeric(str_sub(paddedVar2, start = -1, end = -1)),  # 一の位の足し算解答
         ansTens = as.numeric(str_sub(paddedVar1, start = -2, end = -2)) + as.numeric(str_sub(paddedVar2, start = -2, end = -2)),  # 十の位の足し算解答
         ansHundreds = as.numeric(str_sub(paddedVar1, start = -3, end = -3)) + as.numeric(str_sub(paddedVar2, start = -3, end = -3)),  # 百の位の足し算解答
         isCarried = ansOne >= 10 | ansTens >= 10 | ansHundreds >= 10)  # 繰り上がりしているかどうかのフラグ（TRUE: 繰り上がりあり）





# 引き算 ---------------------------------------------------------------------
# 1桁ー1桁の足し算
subAns1 <- 
  expand.grid(1:9, 1:9) %>% 
  as_tibble() %>% 
  mutate(ans = Var1 - Var2,  # 答え
         isBorrowed = ans <= -1) %>% 
  filter(ans >= 0)  # 答えがマイナスになる組み合わせは削除


# 2桁まで
subAns2 <- 
  expand.grid(1:99, 1:99) %>% 
  as_tibble() %>% 
  mutate(paddedVar1 = str_pad(Var1, 2, pad = "0"),  # 0埋め(padding)した値 
         paddedVar2 = str_pad(Var2, 2, pad = "0"), 
         ans = Var1 - Var2,  # 引き算の解答
         ansOne = as.numeric(str_sub(paddedVar1, start = -1, end = -1)) - as.numeric(str_sub(paddedVar2, start = -1, end = -1)),  # 一の位の答え
         ansTens = as.numeric(str_sub(paddedVar1, start = -2, end = -2)) - as.numeric(str_sub(paddedVar2, start = -2, end = -2)),  # 十の位の答え
         isBorrowed = ansOne <= -1 | ansTens <= -1) %>%   # 繰り上がりしているかどうかのフラグ（TRUE: 繰り上がりあり）
  filter(ans >= 0)  # 答えがマイナスになる組み合わせは削除


# 3桁まで
subAns3 <- 
  expand.grid(1:999, 1:999) %>% 
  as_tibble() %>% 
  mutate(paddedVar1 = str_pad(Var1, 3, pad = "0"),   # 0埋め(padding)した値 
         paddedVar2 = str_pad(Var2, 3, pad = "0"), 
         ans = Var1 - Var2,  # 足し算の解答
         ansOne = as.numeric(str_sub(paddedVar1, start = -1, end = -1)) - as.numeric(str_sub(paddedVar2, start = -1, end = -1)),  # 一の位の足し算解答
         ansTens = as.numeric(str_sub(paddedVar1, start = -2, end = -2)) - as.numeric(str_sub(paddedVar2, start = -2, end = -2)),  # 十の位の足し算解答
         ansHundreds = as.numeric(str_sub(paddedVar1, start = -3, end = -3)) - as.numeric(str_sub(paddedVar2, start = -3, end = -3)),  # 百の位の足し算解答
         isBorrowed = ansOne <= -1 | ansTens <= -1 | ansHundreds <= -1) %>%  # 繰り上がりしているかどうかのフラグ（TRUE: 繰り上がりあり）
  filter(ans >= 0)  # 答えがマイナスになる組み合わせは削除



# 保存 ----------------------------------------------------------------------
# 足し算の答え
saveRDS(addAns1, file = "app/data/addAns1.rds")
saveRDS(addAns2, file = "app/data/addAns2.rds")
saveRDS(addAns3, file = "app/data/addAns3.rds")

# 引き算の答え
saveRDS(subAns1, file = "app/data/subAns1.rds")
saveRDS(subAns2, file = "app/data/subAns2.rds")
saveRDS(subAns3, file = "app/data/subAns3.rds")

