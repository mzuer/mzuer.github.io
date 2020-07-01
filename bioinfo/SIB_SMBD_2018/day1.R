memory.limit()

data(esoph)
object.size(esoph)

library(SASxport)
brfss <- read.xport("LLCP2013.XPT")
head(brfss)
dim(brfss) # 491773 rows, 336 columns

library(epitools)  
oddsratio(as.factor(brfss$X.HCVU651), as.factor(brfss$X.RFCHOL))
# put first column and 2nd columns as factor type
# -> limitation of R, we can load the data etc. but we cannot do any computation on these data

### 1) use different data structure

library(data.table)
brfss_dt <- data.table(brfss)
object.size(brfss_dt)
object.size(brfss)
# information is the same, but data structure is different

library(ff)
# optimization memory and memory storage for computation
# equivalent to SAS framework within R, optimize memory usage


### 2) subset data

# subsetting data by randomly selecting rows
rows_to_select <- sample(1:nrow(brfss), 500, replace=F)  
brfss_sample <- brfss[rows_to_select,] 
oddsratio(as.factor(brfss_sample$X.HCVU651),as.factor(brfss_sample$X.RFCHOL))  

# using database
# SQL query: R packages: RODBC or RMySQL

# once split, need to combine
df <- data.frame(group = factor(sample(c("g1", "g2"), 10, replace=TRUE)), mortality=runif(10))
dt <- data.table(df)
setkey(dt, mortality)

# tapply function
tapply(df$mortality, df$group, mean)

# aggregate function
aggregate(mortality~group, df, mean)

# by
res.by <- by(df$mortality, df$group, mean)
res.by
library(taRifx)
as.data.frame(res.by)

# split only do the split, then combine with apply function
splitmean <- function(df){
  s <- split(df, df$group)
  sapply(s, function(x) mean(x$mortality))
}
splitmean(df)

# functions from reshape2
library(reshape2)
dcast(melt(df), variable ~ group, mean)

# plyr and dplyr packages: efficient for big datasets
library(dplyr)
group_by(df, group) %>% summarize(m = mean(mortality))

library(plyr)
res.plyr <- ddply(df, .(group), function(x) mean(x$mortality))
res.plyr

### benchmark of the different methods
library(microbenchmark) 
library(ggplot2)
m1 <- microbenchmark(   
                        by( df$mortality, df$group, mean),   
                        aggregate(mortality~ group, df, mean ), 
                        splitmean(df), 
                        ddply( df, .(group), function(x) mean(x$mortality) ), 
                        dcast( melt(df), variable ~ group, mean), 
                        dt[, mean(mortality), by = group],   
                        summarize( group_by(df, group), m = mean(mortality) ),   
                        summarize( group_by(dt, group), m = mean(mortality) ) 
                        ) 
print(m1, signif = 3) 
autoplot(m1) 
  

# once split, need to combine
df_1000 <- data.frame(group = factor(sample(c("g1", "g2"), 1000, replace=TRUE)), mortality=runif(1000))
dt_1000 <- data.table(df_1000)
setkey(dt_1000, mortality_1000)
m1_1000 <- microbenchmark(   
  by( df_1000$mortality, df_1000$group, mean),   
  aggregate(mortality~ group, df_1000, mean ), 
  splitmean(df_1000), 
  ddply( df_1000, .(group), function(x) mean(x$mortality) ), 
  dcast( melt(df_1000), variable ~ group, mean), 
  dt_1000[, mean(mortality), by = group],   
  summarize( group_by(df_1000, group), m = mean(mortality) ),   
  summarize( group_by(dt_1000, group), m = mean(mortality) ) 
) 
print(m1_1000, signif = 3) 
ggplot2::autoplot(m1_1000) 

############################################################################################
############################################################################################ CHALLENGE
############################################################################################
# diamonds dataset available from ggplot2

### Case1: Do some operation on every row using apply (which pre-allocates memory):  
start_time1 <- proc.time()  
apply(diamonds, 1, function(row) { row['color'] == 'E' })  
proc.time() - start_time1
# user  system elapsed 
# 0.517   0.088   0.971 

###Case2: Do the same operation but build the response vector through concatenation:  
start_time2 <- proc.time()  
e_diamonds <- c()  
for (row in 1:nrow(diamonds)) {  
  e_diamonds <- c(e_diamonds, diamonds[row, 'color'] == 'E') 
}  
e_diamonds
proc.time() - start_time2
# user  system elapsed 
# 31.877   0.087  33.496 


mDiam <- microbenchmark(   
  apply(diamonds, 1, function(row) { row['color'] == 'E' })  ,
  for (row in 1:nrow(diamonds)) {  
   diamonds[row, 'color'] == 'E' 
  }
) 



############################################################################################
############################################################################################ Revo64 in terminal - exercise 1
############################################################################################

# 1.Use the virtual machine and import the motality.csv file using RevoScaleR Package.︎
mortalityData <- rxImport(inData = "Exercice_revoScaleR-20180604/mortality.csv")
head(mortalityData)

# 2. Transform the data by dropping the column named year︎
mortalityData$year <- NULL
head(mortalityData)

# 3. Transform the data by adding a new column with values high or low:
#   ︎Low when ccExp are between 0 and 6500 and high when  when ccExpare between 6500 and 13000 ︎
mortalityData <- rxImport(inData = "Exercice_revoScaleR-20180604/mortality.csv")
mortalityDataNew <- rxDataStep(
  inData = mortalityData,
  outFile = "tmp.xdf", # Put in a placeholder for an output file
  varsToDrop = c("year"), # Specify any variables to keep or drop
  # Specify a list of new variables to create
  transforms = list(
    expression = cut(ccExp, breaks = c(0, 6500, 13000),
                     labels = c("Low exp", "High exp")))
)


# 4. Transform the data by keeping only score < 625︎5.
mortalityData <- rxImport(inData = "Exercice_revoScaleR-20180604/mortality.csv")
mortalityDataNew <- rxDataStep(
  inData = mortalityData,
  outFile = "tmp2.xdf", # Put in a placeholder for an output file
  rowSelection = score < 6255, # Specify rows to select︎
  varsToDrop = c("year"), # Specify any variables to keep or drop
  # Specify a list of new variables to create
  transforms = list(
    expression = cut(ccExp, breaks = c(0, 6500, 13000),
                     labels = c("Low exp", "High exp")))
)
# Plot the historgram of score for each of the newdatasets created in 1, 2, 3 and 4.

rxHistogram(~score, data = mortalityDataNew )


############################################################################################
############################################################################################ Revo64 in terminal - exercise 2
############################################################################################


# 1.Use the virtual machine and import Flight_Delays_Sample.csv and Weather_Sample.csv files using RevoScaleR Package.
flightData <- rxImport(inData = "Exercice_revoScaleR-20180604/Flight_Delays_Sample.csv")
weatherData <- rxImport(inData = "Exercice_revoScaleR-20180604/Weather_Sample.csv")


# ︎2. Merge the data sets once you have renamed the columns of weather, using  originalAirportID︎
flightData <- rxImport(inData = "Exercice_revoScaleR-20180604/Flight_Delays_Sample.csv")
weatherData <- rxImport(inData = "Exercice_revoScaleR-20180604/Weather_Sample.csv")
colnames(weatherData)[colnames(weatherData) == "AirportID"] <- "OriginAirportID"

# split otherwise take ages
flightData <- flightData[1:500,]
weatherData <- weatherData[1:500,]

mergedData <- rxMerge(inData1=flightData,
          inData2= weatherData,
          outFile = "tmp3.xdf",
          type="full",
          matchVars=c("OriginAirportID"))

# 3. Join flight records and weather data using the destination of the flight DestAirportID︎
flightData <- rxImport(inData = "Exercice_revoScaleR-20180604/Flight_Delays_Sample.csv")
weatherData <- rxImport(inData = "Exercice_revoScaleR-20180604/Weather_Sample.csv")
colnames(weatherData)[colnames(weatherData) == "AirportID"] <- "DestAirportID"

# split otherwise take ages
flightData <- flightData[1:500,]
weatherData <- weatherData[1:500,]

mergedData_dest <- rxMerge(inData1=flightData,
                           inData2= weatherData,
                           outFile = "tmp4.xdf",
                           type="full",
                           matchVars=c("DestAirportID"))

# 4. Call the rxFactors() function to convert OriginAirportID and DestAirportID as categorical.


flightData_converted <- rxFactors(inData = flightData,
           outFile = "tmp5.xdf",
           sortLevels = TRUE,
           factorInfo = c("OriginAirportID", "DestAirportID")
           )︎




