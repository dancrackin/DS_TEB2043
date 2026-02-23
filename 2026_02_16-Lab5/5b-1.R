year <- readline(prompt = "Input year: ")

if (as.integer(trimws(year)) %% 4 == 0)
  {
  if (as.integer(trimws(year)) %% 100 == 0)
    {
    if (as.integer(trimws(year)) %% 400 == 0)
      {
      cat("Output:",year,"is a leap year.")
    } else 
      {
      cat("Output:",year,"is not a leap year.")
    }
  } else 
    {
    cat("Output:",year,"is a leap year.")
  }
} else 
  {
  cat("Output:",year,"is not a leap year.")
}