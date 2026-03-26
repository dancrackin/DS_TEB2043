name = readline(prompt = "Enter your name:")
phoneNumber = readline(prompt = "Enter your phone number:")

nameUpper = toupper(name)

phoneNumberFirst3 = substr(phoneNumber,1,3)
phoneNumberLast4 = substr(phoneNumber, nchar(phoneNumber) - 3,nchar(phoneNumber))

cat("Hi,",nameUpper,". A verification code has been sent to",phoneNumberFirst3,"-XXX",phoneNumberLast4)