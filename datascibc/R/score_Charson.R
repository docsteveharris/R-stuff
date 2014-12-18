# TODO: 2014-12-18 - [ ] add R oxygen comments

score.charlson <- function(data) {
    # data is a datatable containing the columns you need
    # identify the columns with pmh in the name
    require(data.table)
    charlson.values <- data[,.(pmhmi, pmhhf, pmhpvd, pmhcvd, pmhdem, pmhcopd, pmhcopd, pmhctd, pmhud, pmhmld, pmhdm, pmhhemi, pmhckd, pmhdmend, pmhtumour, pmhleuk, pmhlymph, pmhsld, pmhmets, pmhaids)]
    charlson.matrix <- as.matrix(charlson.values)
    # Now I need to convert the NA's to 0 and >0 to 1 in matrix
    charlson.matrix <- apply(charlson.matrix, 2, function(x) ifelse(is.na(x), 0, ifelse(x>=1,1, 0)))
    # Now create a vector of scores
    # Note that the order of the columns selected above *must* match the order of the scores here
    charlson.weight <- matrix(c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 6, 6))
    # Matrix multiply where the 0 or 1 indicator now just creates a weight
    r <- charlson.matrix %*% charlson.weight
    # Now add column back (which asssumes the order is unchanged)
    data <- data.table(data, r)
    setnames(data, "V1", "charlson.score")
}

mydata <- score.charlson(data=mydata)