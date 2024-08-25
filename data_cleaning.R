# Key packages for the app

# install.packages("shiny") # For the shiny app
#  install.packages("bslib") # For certain shiny app traits
#  install.packages("readr") # For loading csv
#  install.packages("shinythemes") # For shiny themes
#  install.packages("thematic") # For consistence between layout and plots
#  install.packages("reactable") # For table
#  install.packages("reactablefmtr") # For table
#  install.packages("here") # For file management
#  install.packages("shinylive") # For github optimisation
#  install.packages("htmltools") # For the DOI links
#  install.packages("magrittr") # For the pipe (avoided tidyverse in case it makes it more difficult for shinyserver)
#  install.packages("dplyr") # For the mutate functions 

# Loading the packages

library(shiny) 
library(bslib)
library(readr)
library(shinythemes)
library(thematic)
library(reactable)
library(reactablefmtr)
library(here)
library(shinylive)
library(htmltools)
library(magrittr)
library(dplyr)


# Uploading the table

Table4 <- 
  read_csv(here("Data",
                "Processed Data",
                "Table4.csv"))

# Now I create the colour code I want the classification variable to have:

Table4 <- Table4 %>%
  mutate(
    Classification_colours = case_when(Classification == "High" ~ "darkgreen",
                                       Classification == "Low" ~ "red",
                                       TRUE ~ "orange")
  )

# Creating a tooltip option that will be used in the headers.

with_tooltip <- function(value, tooltip) {
  tags$abbr(style = "text-decoration: underline; text-decoration-style: dotted; cursor: help",
            title = tooltip, value)
}


# Because of issues hyperlinking to the DOI column in the Table4 data frame,
# a new data frame was created just for that, and the hyperlinks are being
# used from there:

DOITable <- data.frame(
  Study_ID = c("1", "2", "3", "4", "5", "6", "7", "8",  "9", "10",
               "11", "12", "13", "14", "15", "16", "17", "18", "19",
               "20", "21", "22", "23", "24", "25", "26", "27", "28",
               "29", "30", "31"),
  DOI = c("https://doi.org/10.1007/s12310-022-09538-x",
          "https://doi.org/10.1007/s12310-015-9160-1",
          "https://doi.org/10.1093/her/cyu047",
          "https://doi.org/10.1037//0022-006x.67.5.648",
          "http://dx.doi.org/10.1037/spq0000233",
          "Not available",
          "https://doi.org/10.3389/fpsyg.2023.1065749",
          "http://dx.doi.org/10.1016/j.jsp.2014.07.001",
          "https://doi.org/10.1007/s10212-019-00452-6",
          "https://doi.org/10.1080/02796015.2007.12087949",
          "https://doi.org/10.1186/isrctn85087674",
          "https://doi.org/10.1007/s11121-017-0802-4",
          "Not available",
          "https://doi.org/10.1037/e734362011-100",
          "https://doi.org/10.1186/s40359-016-0133-4",
          "https://doi.org/10.1002/ajcp.12092",
          "https://doi.org/10.1007/s11121-018-0948-8",
          "https://doi.org/10.1007/s11121-012-0359-1",
          "https://doi.org/10.1080/14635240.2018.1431952",
          "Not available",
          "Not available",
          "http://dx.doi.org/10.1037/edu0000360",
          "https://doi.org/10.1080/02796015.2012.12087377",
          "https://doi.org/10.1007/s10935-008-0153-9",
          "https://doi.org/10.1086/699153",
          "https://doi.org/10.2196/12003",
          "http://dx.doi.org/10.1016/j.jsp.2017.07.005",
          "https://doi.org/10.3389/fpsyg.2022.973184",
          "https://doi.org/10.3310/phr06100",
          "https://doi.org/10.1007/s11121-016-0670-3",
          "https://doi.org/10.1016/j.jsp.2015.09.002"))
