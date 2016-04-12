library(shiny)
library(shinyTree)
library(shinyjs)
library(V8)
library(dplyr)

js = "
shinyjs.open = function(){
$('#tree').jstree(true).open_all();
}"


shinyUI(
    pageWithSidebar(
        headerPanel("Correct the tree"),
        
        sidebarPanel(useShinyjs(),
                     extendShinyjs(text = js),
                     p('drag and drop to correct the hierarchy, press send to send it to me'),
                     p("don't spam the send button"),
            shinyTree("tree", dragAndDrop=TRUE),
            textInput("comments",'comments'),
            actionButton('send','send')
            ),
        mainPanel(
        )
    ))