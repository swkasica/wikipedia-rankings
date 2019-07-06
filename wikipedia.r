# See article here https://time.com/109947/web-ranking/

library("car")
library("MASS")
library("RJSONIO")

# Added by Steve
parent_dir <- dirname(rstudioapi::getSourceEditorContext()$path)
setwd(parent_dir)
# End added by Steve

data <- read.csv("people.csv")

# Subset only the quantitative data take mean and standard deviation
write(toJSON(sapply(data[-(1:5)],mean)), file="mean.json")
write(toJSON(sapply(data[-(1:5)],sd)), file="sd.json")

# subtract column means from each value within column
standardized = as.data.frame(scale(data[-(1:5)]))

ranking = prcomp(standardized)

screeplot(ranking, type="lines")

write(toJSON(ranking$rotation), file="pca.json")
write.csv(ranking$rotation, file="pca.csv")