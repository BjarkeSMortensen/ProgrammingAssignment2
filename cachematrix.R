## --Asignment--

#This function creates a list containing two objects ("x" and "inv") and four functions ("set", "get", "setinv" and "getinv").
#It can be used to set a matrix and store a matrix and it's invert. The list however does not contain the function to create an
#invert of a matrix. That is what the cacheSolve-function is for.


makeCacheMatrix <- function(x = matrix()) {
  x <- NULL               
  inv <- NULL
  set <- function(y) {    
    x <<- y               
    inv <<- NULL          
  }
  get <- function() {     
    x 
  }                       
  
  setinv <- function(inverse) {                                                                            
    inv <<- inverse
  }
  
  getinv <- function() {
    inv
  }
  
  list(set = set, get = get,
       setinv = setinv,
       getinv = getinv)
}


#This function calls the data stored in the makeCacheMatrix-function. The clever part is that if there for some reason is the inverse of a matrix already stored
#in the makeCacheMatrix-function (the inv-object) then it returns that instead and does not calculate the inverse of the matrix stored in the makeCacheMatrix-function.

cacheSolve <- function(x, ...) {
  inv <- x$getinv()
  if(!is.null(inv)) {
    message("There already is a cache. Getting it cache now")
    print(inv)
  }
  data <- x$get()        
  inv <- solve(data, ...) 
  x$setinv(inv)       
  print(inv)
}





#The following is a repeat of the above with comments explaining the code. It can be ignored.

makeCacheMatrix <- function(x = matrix()) {
  x <- NULL               #Creates the object where the matrix will be put
  inv <- NULL             #Creates the object where the inverse of the matrix will be put
  
  set <- function(y) {    
    x <<- y               
    inv <<- NULL          
    #The set-function will allow you to input a matrix
    #y will be the matrix which is put in  the object x in the parent envorioment (which is the makeCacheMatrix-envorioment)
    #eveytime a new matrix is put in x we purge the object inv for any prior data so we don't call the outdated data
  }
  get <- function() {     
    x 
    #the get function gets the matrix created with the function set
  }                       #You don't need the curly brackets here but I like them because I am used to create functions with them
  
  setinv <- function(inverse) {                                                                            
    inv <<- inverse
    #you this function is used to store the inverse of the matrix. It is in the makeCacheMatrix-envorioment
    #because it is here the inverse of the matrix is stored. The cacheSolve is used to inverse the matrix 
    #but not store the results.                                                                           
  }
  
  getinv <- function() {
    inv
    #like the get-function gets the matrix the getinv-function gets the inverse of the matrix
  }
  
  list(set = set, get = get,
       setinv = setinv,
       getinv = getinv)
  #This is the hidden gem of this function. It makes it so when the makeCacheMatrix-function is stored nn an object
  #then it creates a list of functions and objects which can be called later. It is very clever and not explained anywhere
  #in the course material, which is actually slobby. This should have been included at least in one of the course books...
}




## Write a short comment describing this function

#This function calls the data stored in the makeCacheMatrix-function. The clever part is that if there for some reason is the inverse of a matrix already stored
#in the makeCacheMatrix-function (the inv-object) then it returns that instead and does not calculate the inverse of the matrix stored in the makeCacheMatrix-function.

cacheSolve <- function(x, ...) {
  inv <- x$getinv()
  if(!is.null(inv)) {
    message("There already is a cache. Getting it cache now")
    print(inv)
  }
  #This first part checks if already is a inversed matrix stored in the makeCacheMatrix-function. If there is it will print the results.
  #however if there isn't then it the function will proceed with the function.
  
  data <- x$get()         #The cacheSolve-function gets the data from the makeCacheMatrix-function.
  inv <- solve(data, ...) #This part creates the inverse matrix of the matrix stored by the makeCacheMatrix-function.
  x$setinv(inv)           #This sets the inverse matrix into the inv-object in the makeCacheMatrix-function. It searches for the setinv-function in the other enviroment,
  #and puts the inverted matrix in the makeCacheMatrix-function. Really clever stuff.
  print(inv)              #This function simply prints the results.
}


