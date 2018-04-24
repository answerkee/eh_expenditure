#Package installation instructions 

install.packages("library") 
install.packages("readxl")
library(readxl)

#import data set from Excel 

EH_Set <- read_excel("/Users/keeharish/Desktop/Secondary_Data_EH_Raw_Report\ .xlsx")

#remove unneeded variables 

EH_Set$member_city <- NULL
EH_Set$physician_paid <- NULL
EH_Set

#replace missing values with 0

EH_Set[is.na(EH_Set)] <- 0
EH_Set

#aggregate payments

EH_agg <- aggregate(list(EH_Set$ded_oop, EH_Set$copay_oop, EH_Set$medical_paid, EH_Set$rx_paid, EH_Set$total_paid), by=list(Category=EH_Set$member_id), FUN=sum)
colnames(EH_agg) <- list("member_id", "ded", "copay", "medical", "rx_paid", "total_paid")
EH_agg

#calculate total out of pocket 

EH_agg$total_oop <- EH_agg$ded + EH_agg$copay
EH_agg$total_oop
EH_agg

# include member counties 

EH_counties <- read_excel("/Users/keeharish/Desktop/Member\ Counties\ .xlsx")

EH_agg_counties <- merge(EH_agg, EH_counties)







