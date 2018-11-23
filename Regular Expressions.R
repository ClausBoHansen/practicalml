
# Get regex match
inputstr <- "Anything after - is not interesting"
reg <- regexpr("^[^-]*", inputstr)
matchedstring <- regmatches(inputstr, reg)