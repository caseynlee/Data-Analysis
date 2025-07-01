knitr::opts_chunk$set(echo = TRUE)
library(ggplot2)
library(dplyr)
library(tidyr)

data = read.csv("US_Accidents_March23_sampled_500k.csv")

head(data)
colnames(data)

cleaned_data <- data %>% select(
  Severity, Distance.mi., Description, Start_Lat, Start_Lng, City, County, State,
  Start_Time, End_Time, Timezone, Temperature.F., Wind_Chill.F., Humidity...,
  Pressure.in., Visibility.mi., Wind_Direction, Wind_Speed.mph., Precipitation.in.,
  Weather_Condition, Amenity, Bump, Crossing, Junction, No_Exit,
  Traffic_Calming, Traffic_Signal
)

cleaned_data <- cleaned_data %>% 
  select(
    which(colSums(is.na(.)) / nrow(.) < 0.5)
  )

cleaned_data <- cleaned_data %>% drop_na(Severity, Start_Time, Start_Lat, Start_Lng)

cleaned_data <- cleaned_data %>%
  mutate(
    Start_Time = as.POSIXct(Start_Time, format = "%Y-%m-%d %H:%M:%S"),
    End_Time = as.POSIXct(End_Time, format = "%Y-%m-%d %H:%M:%S")
  )

categorical_cols <- c("City", "County", "State", "Timezone", "Weather_Condition",
                      "Wind_Direction", "Amenity", "Bump", "Crossing", "Junction",
                      "No_Exit", "Traffic_Calming", "Traffic_Signal")
cleaned_data <- cleaned_data %>% mutate(across(all_of(categorical_cols), as.factor))



cleaned_data <- cleaned_data %>%
  mutate(Duration = as.numeric(difftime(End_Time, Start_Time, units = "mins")))

cleaned_data <- cleaned_data %>%
  mutate(Time_of_Day = case_when(
    format(Start_Time, "%H") %in% c(6:11) ~ "Morning",
    format(Start_Time, "%H") %in% c(12:17) ~ "Afternoon",
    format(Start_Time, "%H") %in% c(18:21) ~ "Evening",
    TRUE ~ "Night"
  ))

cleaned_data <- na.omit(cleaned_data)
print(colnames(cleaned_data))

# save to csv
write.csv(cleaned_data, "cleaned_data.csv", row.names = FALSE)

cleaned_data <- read.csv("cleaned_data.csv")

sampled_data <- cleaned_data %>%
  group_by(Severity) %>%
  slice_sample(n = 400) %>%
  ungroup()

head(sampled_data)

write.csv(sampled_data, "sampled_data4.csv", row.names = FALSE)