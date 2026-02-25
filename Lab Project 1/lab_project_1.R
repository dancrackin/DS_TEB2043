library(tidyverse)
library(lubridate)

file_path <- "C:\\Users\\user\\Documents\\Uni Stuff\\UG Y2S2\\TEB2043 Data Science\\DS_TEB2043\\Lab Project 1\\unclean_dataset.csv"
save_path <- "C:\\Users\\user\\Documents\\Uni Stuff\\UG Y2S2\\TEB2043 Data Science\\DS_TEB2043\\Lab Project 1\\cleaned_dataset.csv"

df <- read.csv(file_path)

# ====================================
# --- The Cleaning Process Phase 1 ---
# Separating and inserting data to its correct column

# Define the exact column names we want to separate into
col_names <- c("Student_ID", "First_Name", "Last_Name", "Age", "Gender", 
               "Course", "Enrollment_Date", "Total_Payments")

# Create a condition to check if the row has a "|" symbol
has_pipe <- grepl("\\|", df$Student_ID)

# Keep the rows that DO NOT have pipes exactly as they are (skipping them)
df_clean <- df[!has_pipe, ]

# Process ONLY the rows that have the "|" symbol
df_fixed <- df[has_pipe, ] %>%
    # Select only the Student_ID column to drop the old junk data (overwriting it)
    select(Student_ID) %>%
    # Separate the single column into multiple columns based on the pipe symbol
    separate(
        col = Student_ID, 
        into = col_names, 
        sep = "\\|", 
        fill = "right"
    ) %>%
    # Remove all leading and trailing whitespaces from all columns
    mutate(across(everything(), trimws)) %>%
    # Convert any blank strings (from things like |   |) into proper NA values
    mutate(across(everything(), ~ na_if(., "")))

# Combine the skipped (clean) rows back with our newly fixed rows
df_phase_1 <- bind_rows(df_clean, df_fixed)

# ====================================
# --- The Cleaning Process Phase 2 ---
# Remove Student ID column, this column too corrupted (half missing from the dataset, duplicates but different student data)

df_phase_2 <- df_phase_1 %>%
    select(-Student_ID)

# ====================================
# --- The Cleaning Process Phase 3 ---
# Split combined first and last names from First_Name column to its correct column

df_phase_3 <- df_phase_2 %>%
    mutate(
        # 1. Update Last_Name FIRST! 
        # If First_Name has a space, extract everything from the 2nd word to the end.
        # Otherwise, leave the Last_Name exactly as it is.
        Last_Name = ifelse(
            str_detect(First_Name, " "), 
            word(First_Name, start = 2, end = -1), 
            Last_Name
        ),
        
        # 2. Update First_Name SECOND!
        # If it has a space, keep ONLY the 1st word. 
        # Otherwise, leave it as is.
        First_Name = ifelse(
            str_detect(First_Name, " "), 
            word(First_Name, 1), 
            First_Name
        )
    )

# ====================================
# --- The Cleaning Process Phase 4 ---
# Fixing formatting and swapped data for Age and Gender column

df_phase_4 <- df_phase_3 %>%
    mutate(
        # FIX THE SWAPPED DATA (e.g., Age = "M", Gender = "25")
        is_swapped = coalesce(str_detect(Age, "[A-Za-z]"), FALSE),
        
        Temp_Age = ifelse(is_swapped, Gender, Age),
        Temp_Gender = ifelse(is_swapped, Age, Gender),
        
        # FIX THE MERGED DATA (e.g., Age = "", Gender = "M 25")
        # Detect if Temp_Gender has a number AND Temp_Age is missing/empty
        is_merged = coalesce(str_detect(Temp_Gender, "\\d"), FALSE) & 
            coalesce(Temp_Age == "" | is.na(Temp_Age), FALSE),
        
        # If merged, extract the digits from Temp_Gender. Otherwise, keep Temp_Age.
        Temp_Age = ifelse(is_merged, str_extract(Temp_Gender, "\\d+"), Temp_Age),
        
        # CLEANUP
        # Remove asterisks from Age
        Age = str_remove_all(Temp_Age, "\\*"),
        
        # Extract ONLY the first letter from Gender (this safely turns "M 25" into "M")
        Gender = str_extract(Temp_Gender, "[A-Za-z]"),
        Gender = toupper(Gender)
    ) %>%
    
    # Drop our temporary holding columns
    select(-is_swapped, -is_merged, -Temp_Age, -Temp_Gender)

# ====================================
# --- The Cleaning Process Phase 5 ---
# Remove symbols from Total Payments column

df_phase_5 <- df_phase_4 %>%
    mutate(
        # 1. Scrub the text to remove any corrupted, unreadable characters
        Total_Payments = iconv(Total_Payments, to = "UTF-8", sub = ""),
        
        # 2. Extract ONLY the numbers (this automatically removes $, spaces, and letters)
        Total_Payments = parse_number(Total_Payments)
    )

# ====================================
# --- The Cleaning Process Phase 6 ---
# Remove any rows that have missing value and Remove duplicates

df_phase_6 <- df_phase_5 %>%
    # 1. Trim whitespace from all remaining character columns
    mutate(across(where(is.character), trimws)) %>%
    
    # 2. Convert completely empty strings into official NA values
    mutate(across(where(is.character), ~ na_if(., ""))) %>%
    
    # 3. Convert the literal word "NA" to actual missing NA 
    mutate(across(where(is.character), ~ na_if(., "NA"))) %>%
    
    # 4. NOW drop the rows containing NAs
    drop_na()

# ====================================
# --- The Cleaning Process Phase 7 ---
# Fixing formatting and remove rows where date is in the future for Date column

df_phase_7 <- df_phase_6 %>%
    mutate(
        # PARSE THE MIXED FORMATS
        # Give R the "cheat sheet" of formats to look for:
        # "mdy" = Month/Day/Year (for 6/25/2022)
        # "ymd" = Year-Month-Day (for 2022-05-15)
        # "dmy" = Day-Month-Year (for 31-Aug-23)
        Enrollment_Date = parse_date_time(Enrollment_Date, orders = c("mdy", "ymd", "dmy")),
        
        # CONVERT TO ISO 8601
        # parse_date_time adds a timestamp by default (e.g., 2022-05-15 00:00:00).
        # as.Date strips the time away, leaving pure ISO 8601 YYYY-MM-DD
        Enrollment_Date = as.Date(Enrollment_Date)
    ) %>%
    
    # REMOVE FUTURE DATES
    # Keep dates that are today or earlier, OR missing entirely
    filter(Enrollment_Date <= Sys.Date() | is.na(Enrollment_Date))

# ====================================
# --- The Cleaning Process Phase 8 ---
# Spelling and format for column Course

df_phase_8 <- df_phase_7 %>%
    # DROP ROWS WITH NUMBERS
    # str_detect looks for any digit (\\d). coalesce() ensures NA values 
    # don't break the filter, allowing them to pass through to be handled later.
    filter(!str_detect(coalesce(Course, ""), "\\d")) %>%
    
    # FIX SPELLING ERRORS
    mutate(
        Course = case_when(
            # Fix Machine Learning typo
            Course == "Machine Learnin" ~ "Machine Learning",
            
            # Fix Web Development typos (using %in% to catch all 3 variations at once)
            Course %in% c("Web Developmen", "Web Developmet", "Web Develpment") ~ "Web Development",
            
            # TRUE ~ Course means "for everything else, leave it exactly as it is"
            TRUE ~ Course
        )
    )

# ========================================
# --- The Cleaning Process Phase Final ---
# Remove duplicates
    
df_phase_final <- df_phase_8 %>%
    distinct()

# View the result
print(df_phase_final)

# Save result to new csv
write.csv(df_phase_final, save_path)
