# Comparing 2 strings (case-insensitive)

text1 <- readline(prompt = "Enter the first word: ")
text2 <- readline(prompt = "Enter the second word: ")

isSimilar <- tolower(text1) == tolower(text2)

print(isSimilar)