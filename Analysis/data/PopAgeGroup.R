########################
# Lars Mehwald and Daniel Salgado Moreno
# 11 December 2015
# Population Age as percentage of total population
########################

# Loading the data
PopAgeGroup <- read.csv(file="Analysis/data/RawData/PopAgeRawData.csv",
                          sep=",", 
                          dec=",",
                          na.strings=c("."), 
                          header = FALSE,
                          skip=7,
                          nrows = 523, 
                          col.names = c("year", 
                                        "district", 
                                        "DistrictName", 
                                        "Pop0to17", 
                                        "Pop18to24", 
                                        "Pop25to44", 
                                        "Pop45to64", 
                                        "PopOver65"))

# Converting Character Vectors between Encodings from latin1 to UTF-8
# More compatibility with German characters
PopAgeGroup$DistrictName <- iconv(PopAgeGroup$DistrictName, from ="latin1", to = "UTF-8")

# Removing higher political units (they are coded with numbers below 1000)
# Keeping only district$Berlin = 11; district$Hamburg = 2; 
PopAgeGroupBerHam <- subset(PopAgeGroup, PopAgeGroup$district == 2 | PopAgeGroup$district ==11, all(TRUE))
PopAgeGroup <- PopAgeGroup[PopAgeGroup$district > 1000,]
PopAgeGroup <- rbind(PopAgeGroup, PopAgeGroupBerHam)
rm(PopAgeGroupBerHam)

# Removing redundant districts
# (We keep for district$Aachen=5334, district$Hannover=3241, district$Saarbrücken=10041)
PopAgeGroup <- subset(PopAgeGroup, PopAgeGroup$district < 17000, all(TRUE))

# Preparing for merging: deleting some columns 
PopAgeGroup <- PopAgeGroup[,-c(1,3)]

# Changing the class of Variables 
PopAgeGroup[,1] <- as.numeric(as.character(PopAgeGroup[,1]))
PopAgeGroup[,2] <- as.numeric(as.character(PopAgeGroup[,2]))
PopAgeGroup[,3] <- as.numeric(as.character(PopAgeGroup[,3]))
PopAgeGroup[,4] <- as.numeric(as.character(PopAgeGroup[,4]))
PopAgeGroup[,5] <- as.numeric(as.character(PopAgeGroup[,5]))
PopAgeGroup[,6] <- as.numeric(as.character(PopAgeGroup[,6]))

#saving population groups data frame 
write.csv(PopAgeGroup, file = "Analysis/data/PopAgeGroup.csv")
