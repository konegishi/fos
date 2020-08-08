#server

# packageのロード
# pacman::p_load(shiny,
#                tidyverse,
#                shinycustomloader)
library(shiny)
library(tidyverse)



# user.base <- readRDS(file = "data/userBase.rds")

# サーバー側の処理 ----------------------------------------------------------------
shinyServer(function(input, output) {


# 設定ページのUI ----------------------------------------------------------------
  output$calSettings <- renderUI({
    h2("計算プリントの設定")
  })

  

# 生成したプリントのUI -------------------------------------------------------------
  output$calPrint <- renderUI({
    h2("名前")
    HTML("<p>hoge</p>")
  })
})