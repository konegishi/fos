#server

# packageのロード
# pacman::p_load(shiny,
#                tidyverse,
#                shinycustomloader)
library(shiny)
library(tidyverse)
library(glue)



# user.base <- readRDS(file = "data/userBase.rds")

# サーバー側の処理 ----------------------------------------------------------------
shinyServer(function(input, output) {


# 設定ページのUI ----------------------------------------------------------------
  # output$calSettings <- renderUI({
  #   h2("計算プリントの設定")
  # })


  

# 問題の選択 -------------------------------------------------------------------
  ansTable <- reactive({
    # print(input&radioCal)
    switch(input$digitNum,
           "1" = readRDS(file = "data/num1.rds"),
           "2" = readRDS(file = "data/num2.rds"),
           "3" = readRDS(file = "data/num2.rds"))
  })
  
  hoge <- "hoge"
  
  var1 <- reactive({
    return(ansTable()$Var1[1])
  })
  
# 生成したプリントのUI -------------------------------------------------------------
  output$calPrint <- renderUI({
    withTags({
      div(class = "main",
          p(class = "name", 
            "なまえ："),
          
          # 左列
          div(class = "column",
              ul(
                li("(1) {var1()[1]} + {var2()[1]} = "),
                li(glue("(2) {var1()[1]}")),
                li("(3)"),
                li("(4)"),
                li("(5)"),
                li("(6)"),
                li("(7)"),
                li("(8)"),
                li("(9)"),
                li("(10)")
              )
          ),
          
          # 右列
          div(class = "column",
              ul(
                li("(11)"),
                li("(12)"),
                li("(13)"),
                li("(14)"),
                li("(15)"),
                li("(16)"),
                li("(17)"),
                li("(18)"),
                li("(19)"),
                li("(20)")
              )
          )
      )
    })
  })
  
  
  # output$calPrint <- renderUI({
  #   withTags({
  #     div(class = "main",
  #         h3("なまえ："),
  #         fluidRow(
  #           column(6,
  #                  withTags({
  #                    div(class = "leftColumn",
  #                        ul(
  #                          li("(1)"),
  #                          li("(2)"),
  #                          li("(3)"),
  #                          li("(4)"),
  #                          li("(5)"),
  #                          li("(6)"),
  #                          li("(7)"),
  #                          li("(8)"),
  #                          li("(9)"),
  #                          li("(10)")
  #                        )
  #                        )
  #                  })
  #           ),
  #           column(6,
  #                  withTags({
  #                    div(class = "rightColumn",
  #                        ul(
  #                          li("(11)"),
  #                          li("(12)"),
  #                          li("(13)"),
  #                          li("(14)"),
  #                          li("(15)"),
  #                          li("(16)"),
  #                          li("(17)"),
  #                          li("(18)"),
  #                          li("(19)"),
  #                          li("(20)")
  #                          )
  #                        )
  #                  })
  #           )))
  #   })
  # })
})

