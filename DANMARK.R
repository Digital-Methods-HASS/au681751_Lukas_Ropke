#Danmap
library(leaflet)
library(htmlwidgets)
Danmap <- leaflet() %>%   # assign the base location to an object
  setView(10, 56, zoom = 7)
esri <- grep("^Esri", providers, value = TRUE)
for (provider in esri) {
  Danmap <- Danmap %>% addProviderTiles(provider, group = provider)
}
DANMAP <- Danmap %>%
  addLayersControl(baseGroups = names(esri),
                   options = layersControlOptions(collapsed = FALSE)) %>%
  addMiniMap(tiles = esri[[1]], toggleDisplay = TRUE,
             position = "bottomright") %>%
  addMeasure(
    position = "bottomleft",
    primaryLengthUnit = "meters",
    primaryAreaUnit = "sqmeters",
    activeColor = "#3D535D",
    completedColor = "#7D4479") %>% 
  htmlwidgets::onRender("
                        function(el, x) {
                        var myMap = this;
                        myMap.on('baselayerchange',
                        function (e) {
                        myMap.minimap.changeLayer(L.tileLayer.provider(e.name));
                        })
                        }") %>% 
  addControl("", position = "topright")
DANMAP
saveWidget(DANMAP, "DANMAP.html", selfcontained = TRUE)
places <- read_sheet("https://docs.google.com/spreadsheets/d/1PlxsPElZML8LZKyXbqdAYeQCDIvDps2McZx1cTVWSzI/edit#gid=124710918",
                     col_types = "cccnncnc",   # check that you have the right number and type of columns
                     range = "DM2023")
glimpse(places)
leaflet() %>% 
  addTiles() %>% 
  addMarkers(lng = places$Longitude, 
             lat = places$Latitude,
             clusterOptions = markerClusterOptions,
             popup = paste("Lon & lat:", places$Longitude, places$Latitude, "<br>", "Type:", places$Type, "<br>",
                           places$Description))%>%
  
  
  addLayersControl(baseGroups = names(esri),
                   options = layersControlOptions(collapsed = FALSE)) %>%
  addMiniMap(tiles = esri[[1]], toggleDisplay = TRUE,
             position = "bottomright") %>%
  addMeasure(
    position = "bottomleft",
    primaryLengthUnit = "meters",
    primaryAreaUnit = "sqmeters",
    activeColor = "#3D535D",
    completedColor = "#7D4479") %>% 
  htmlwidgets::onRender("
                        function(el, x) {
                        var myMap = this;
                        myMap.on('baselayerchange',
                        function (e) {
                        myMap.minimap.changeLayer(L.tileLayer.provider(e.name));
                        })
                        }") %>% 
  addControl("", position = "topright")
saveWidget(DANMAP, "DANMAPFINAL.html", selfcontained = TRUE)


# Task 3: Can you cluster the points in Leaflet?
# Hint: Google "clustering options in Leaflet in R"
# Yes it is possible using "clusterOptions = markerClusterOptions()"

# Solution

######################################## TASK FOUR

# Task 4: Look at the two maps (with and without clustering) and consider what
# each is good for and what not.

# Your brief answer
#Without clusters it becomes easier to see the different points. That is if there is a little amount of popups
#With clusters, having a larger amount of points becomes more organised and easier to work with a set location
