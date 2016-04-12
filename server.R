library(shiny)
library(shinyTree)
library(shinyjs)
library(mailR)
library(V8)
library(dplyr)

#' Define server logic required to generate a simple tree
#' @author Jeff Allen \email{jeff@@trestletech.com}
shinyServer(function(input, output, session) {
    output$tree <- renderTree({
        delay(500,
              js$open())
        return(list(All = list(Cerebellum='',
                               SpinalCord='',
                               Cerebrum = list(Striatum = '',
                                               Cortex = '',
                                               Subependymal= '',
                                               BasalForebrain = '',
                                               Amygdala = '',
                                               Brainstem = list(LocusCereuleus='',
                                                                Thalamus = ''),
                                               Hippocampus = ''))))
    })
    
     observe({input$tree
         delay(100,
               js$open())})
    
    observeEvent(input$send,{
        # browser()
        print('attempting to send')
        treeLayers = input$tree %>% unlist(recursive = TRUE) %>% names

        input$comments

        send.mail(from='ltoker@bla.com', to = 'ogan.mancarcii@gmail.com', subject = 'tree',
                  body = paste0(input$comments, '\n\n',paste(treeLayers,collapse='\n')),
                  smtp = list(host.name = "aspmx.l.google.com", port = 25))
    })
})