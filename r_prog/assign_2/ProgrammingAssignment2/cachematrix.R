## Overall description 
# This function creates a special "matrix" object

# The functions returned are capable of:
# 1 Set the matrix value
# 2 Get the matrix value
# 3 Set the matrix inverse value
# 4 Get the matrix inverse value

makeCacheMatrix <- function(x = matrix()) {
  inv <- NULL
  set <- function(y) {
    x <<- y
    inv <<- NULL
  }
  get <- function() x
  setinverse <- function(inverse) inv <<- inverse
  getinverse <- function() inv
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)

}


## Overall description 
# This function calculates the special "matrix" inverse
# if the inverse has already been calculated it returns
# the value stored in cache
# P.S: The object used as argument should be created with
# the above function

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  inv <- x$getinverse()
  if(!is.null(inv)) {
    message("getting cached data")
    return(inv)
  }
  data <- x$get()
  inv <- solve(data, ...)
  x$setinverse(inv)
  inv
}

